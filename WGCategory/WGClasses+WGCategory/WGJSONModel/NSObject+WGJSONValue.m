//
//  NSObject+WGJSONValue.m
//  WGCategory
//
//  Created by 丝瓜&冬瓜 on 15/6/14.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "NSObject+WGJSONValue.h"

#pragma mark - json解析
@implementation NSString(WGJSONValue)
- (id )JSONValue {
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}
@end

#pragma mark - value转json
@implementation NSArray (WGJSONValue)
- (NSString *)JSONString {
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return @"";
    return result;
}
@end
@implementation NSDictionary (WGJSONValue)
- (NSString *)JSONString {
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return @"";
    return result;
}
@end
