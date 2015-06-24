//
//  NSObject+WGModelValue.m
//  WGCategory
//
//  Created by RayMi on 15/6/15.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "NSObject+WGModelValue.h"
#import <objc/runtime.h>
#import "WGDefines.h"
#pragma mark -
@implementation NSObject (WGModelValue)
- (id )modelValue{
    //此处方法如被调用，则可以视为self为model，否则会走各自基本类型的方法
    NSMutableDictionary *json = @{}.mutableCopy;
    
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++){
        
        const char* propertyName_CStr = property_getName(properties[i]);
        
        //model属性名
        NSString *propertyName_NSString = [NSString stringWithFormat:@"%s",propertyName_CStr];
        
        id value = [self valueForKey:propertyName_NSString];
        
        //将value深层转化
        value = [value modelValue];
        
        //确保value不是null
        if (!value) {
            value = @"";
        }
        
        [json setValue:value forKey:propertyName_NSString];
    }
    free(properties);
    
    return json;
}
@end

#pragma mark -
@interface NSArray (WGModelValue)
- (instancetype)modelValue;
@end
@implementation NSArray (WGModelValue)
- (instancetype )modelValue{
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        [tmp addObject:[obj modelValue]];
    }
    return tmp;
}
@end

#pragma mark -
@interface NSDictionary (WGModelValue)
- (instancetype)modelValue;
@end
@implementation NSDictionary (WGModelValue)
- (instancetype )modelValue{
    return self;
}
@end

#pragma mark -
@interface NSString (WGModelValue)
- (instancetype)modelValue;
@end
@implementation NSString (WGModelValue)
- (instancetype )modelValue{
    return self;
}
@end

#pragma mark -
@interface NSNumber (WGModelValue)
- (instancetype)modelValue;
@end
@implementation NSNumber (WGModelValue)
- (instancetype )modelValue{
    return self;
}
@end

#pragma mark -
@interface NSValue (WGModelValue)
- (instancetype)modelValue;
@end
@implementation NSValue (WGModelValue)
- (instancetype )modelValue{
    return self;
}
@end


