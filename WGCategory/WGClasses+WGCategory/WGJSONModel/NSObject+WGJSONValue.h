//
//  NSObject+WGJSONValue.h
//  WGCategory
//
//  Created by 丝瓜&冬瓜 on 15/6/14.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - json解析
@interface NSString(WGJSONValue)
- (id )JSONValue;
@end

#pragma mark - value转json
@interface NSArray (WGJSONValue)
- (NSString *)JSONString;
@end
@interface NSDictionary (WGJSONValue)
- (NSString *)JSONString;
@end
