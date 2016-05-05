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
    return data.JSONValue;
}
@end
@implementation NSData (WGJSONValue)
- (id )JSONValue{
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:self
                                                options:kNilOptions
                                                  error:&error];
    if (error != nil) return nil;
    return result;
}
@end

#pragma mark - value转json
@implementation NSArray (WGJSONValue)
- (NSString *)JSONString {
    NSData *data = self.JSONData;
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
- (NSData *)JSONData{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions
                                                  error:&error];
    if (error != nil) return nil;
    return result;
}
@end
@implementation NSDictionary (WGJSONValue)
- (NSString *)JSONString {
    NSData *data = self.JSONData;
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
- (NSData *)JSONData{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions
                                                  error:&error];
    if (error != nil) return nil;
    return result;
}
@end
