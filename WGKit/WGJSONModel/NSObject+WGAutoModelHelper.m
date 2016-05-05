//
//  NSObject+AutoModelHelper.m
//  WeCommunity
//
//  Created by iOS ZYJ on 14-11-24.
//  Copyright (c) 2014年 Eduoduo. All rights reserved.
//

#import "NSObject+WGAutoModelHelper.h"
#import <objc/runtime.h>
#import "WGDefines.h"

#define PropertyDeclaration(value,propertyAttributes,propertyName) ([NSString stringWithFormat:@"@property (nonatomic,%@) %@ *%@;",[NSObject retainTypeFromValue:value],propertyAttributes,propertyName])

@interface NSObject (WGModelHelper)
@end
@implementation NSObject (WGModelHelper)
+ (NSString *)publicClassNameWithValue:(id )value{
    //eg:
    if ([value isKindOfClass:[NSString class]]) {
        return @"NSString";
    }
    else if ([value isKindOfClass:[NSNumber class]]){
        return @"NSNumber";
    }
    else if ([value isKindOfClass:[NSArray class]]){
        return @"NSArray";
    }
    else if ([value isKindOfClass:[NSNumber class]]){
        return @"NSNumber";
    }
    else if ([value isKindOfClass:[NSDictionary class]]){
        return @"NSDictionary";
    }
    else if ([value isKindOfClass:[NSNumber class]]){
        return @"NSNumber";
    }
    else
        return @"id";
}
/**
 *  根据类名，返回此类的retain类型，
 *
 *  @param name 类名
 *
 *  @return assign、strong、copy
 */
+ (NSString *)retainTypeFromValue:(id )value{
    if ([value isKindOfClass:[NSString class]]) {
        return @"copy";
    }
    else
        return @"strong";//一般对象都为string类型
}
@end
#pragma mark - 数据转model声明打印
@implementation NSArray (GENERATE_DEBUG)
- (NSString *)logWithKey:(NSString *)key{
    key = [[NSString handleNetString:key] uppercaseFirstString];
    key = [NSString stringWithFormat:@"%@",key];
    for (id obj in self) {
        if ([obj respondsToSelector:@selector(logWithKey:)]) {
            [obj logWithKey:key];
        }
        break;
    }
    return @"NSArray";
}
@end

#pragma mark -
@implementation NSDictionary (GENERATE_DEBUG)
- (NSString *)logWithKey:(NSString *)key{
    key = [[NSString handleNetString:key] uppercaseFirstString];
    NSMutableString *property = [NSMutableString stringWithString:@"\n\n\n"];
    [property appendFormat:@"@interface %@:NSObject\n",key];
    for (NSString *k in [self allKeys]) {
        id value = self[k];
        NSString *uppercaseK = [k uppercaseFirstString];
        //属性原始类型名称
        NSString *propertyAttributes = [NSObject publicClassNameWithValue:value];
        //如果value可实现logWithKey方法，则调用
        if ([value respondsToSelector:@selector(logWithKey:)]) {
            propertyAttributes = [value logWithKey:[NSString stringWithFormat:@"%@_%@",key,uppercaseK]];
        }
        [property appendString:PropertyDeclaration(value, propertyAttributes, k)];
        [property appendString:@"\n"];
    }
    [property appendString:@"@end\n"];
    [property appendFormat:@"@implementation %@ \n@end\n\n\n",key];
    WGLogMsg(property);
    return key;
}
@end






