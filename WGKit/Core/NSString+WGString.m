//
//  WGCategory+NSString.m
//  WGCategoryAppend
//
//  Created by Apple on 13-12-30.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "NSString+WGString.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString(Category)
#pragma mark ----------------------------
#pragma mark 检测服务器返回数据是否为null，返回WGNull或者对象为NSNumber转为NSString返回
+ (NSString *)handleNetString:(id )string{
    if ([string isKindOfClass:[NSString class]]) {
        if ([(NSString *)string length]==0) {//为空字符
            return @"";
        }
        return string;
    }
    else if ([string isKindOfClass:[NSNumber class]]) {//为纯数字，格式化
        return [NSString stringWithFormat:@"%@",string];
    }
    else if([string isKindOfClass:[NSNull class]] || !string){//为null
        return @"";
    }
    else{//其他，比如NSArray。。。原类型返回
        return string;
    }
}

#pragma mark ----------------------------
#pragma mark 正则表达式
- (BOOL)isMatchingRegularEpressionByPattern:(NSString *)pattern{
    //nil 调用此方法，不执行，返回NO
    NSError *error;
    //检测正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (nil != regex) {
        NSRange firstMatch = [regex rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
        if (firstMatch.location==0 && firstMatch.length==self.length) {
            return YES;
        }
    }
    return NO;
}
- (NSArray *)stringFromRegularEpression:(NSString *)pattern{
    NSError *error;
    //检测正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (regex) {
        NSArray *results = [regex matchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
        NSMutableArray *texts = @[].mutableCopy;
        
        for (NSTextCheckingResult *result in results) {
            [texts addObject:[self substringWithRange:result.range]];
        }
        
        return [NSArray arrayWithArray:texts];
    }
    return nil;
}

#pragma mark - NSObject 无差别地 转化为 NSString lv从0开始
const static NSString *_blank = @"\t";
+ (NSString *)changeObjToString:(id )obj CurLV:(int )lv{
    NSMutableString *string = [NSMutableString string];
    NSMutableString *blank = [NSMutableString string];
    for (int i = 0; i < lv; i++) {
        [blank appendString:(NSString *)_blank];
    }
    
    if ([obj isKindOfClass:[NSString class]]) {
        [string appendString:blank];
        [string appendString:obj];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        [string appendString:blank];
        [string appendString:@"("];

        for (int i = 0; i < [obj count]; i++) {
            id sub = obj[i];
            [string appendString:@"\n"];
            [string appendString:[self changeObjToString:sub CurLV:lv+1]];
            
            if (i!=[obj count]-1) {
                [string appendString:@","];
            }
        }
        
        [string appendString:@"\n"];
        [string appendString:blank];
        [string appendString:@")"];
    }
    else if ([obj isKindOfClass:[NSDictionary class]]){
        [string appendString:blank];
        [string appendString:@"{"];
        
        for (NSString *key in [obj allKeys]) {
            [string appendString:@"\n"];
            [string appendString:blank];
            [string appendString:(NSString *)_blank];
            [string appendFormat:@"%@=%@;",key,[self changeObjToString:obj[key] CurLV:lv+1]];
        }
        
        [string appendString:@"\n"];
        [string appendString:blank];
        [string appendString:@"}"];
    }else{//NSObject
        [string appendString:blank];
        [string appendString:[obj description]];
    }
    return [self replaceUnicode:string];
}
- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (int )strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData
                                                                    options:NSPropertyListImmutable
                                                                     format:NULL
                                                                      error:nil];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}
- (NSString *)uppercaseFirstString {
    if (self.length==0 || self.length==1) {
        return self;
    }else{
        NSString *firstCharacter = [[self substringToIndex:1] uppercaseString];
        NSString *lastString = [self substringFromIndex:[self rangeOfComposedCharacterSequenceAtIndex:1].location];
        lastString = lastString.length?lastString:@"";
        return [firstCharacter stringByAppendingString:lastString];
    }
}

- (NSString *)starString:(NSString *)replace {
    return [self starString:replace withMaxLenght:4];
}
- (NSString *)starString:(NSString *)replace withMaxLenght:(NSUInteger )maxLen {
    NSUInteger len = MIN(maxLen, self.length / 2);
    NSMutableString *stars = @"".mutableCopy;
    for (NSUInteger i = 0; i < len; i++) {
        [stars appendString:replace];
    }
    NSUInteger from = self.length / 2 - len / 2;
    NSString *newStr = [self stringByReplacingCharactersInRange:NSMakeRange(from, len) withString:stars];
    return newStr;
}

@end
