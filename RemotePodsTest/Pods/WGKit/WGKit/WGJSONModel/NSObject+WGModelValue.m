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

#pragma mark - WGSQL支持的属性转column类型定义
@interface WGNullValueHelper : NSObject
@property NSString *NSString;
@property NSMutableString *NSMutableString;
@property NSNumber *NSNumber;
//@property NSData *NSData;//一般model不会保有此种类型的属性，故不作考虑
//@property NSMutableData *NSMutableData;//一般model不会保有此种类型的属性，故不作考虑
@property NSArray *NSArray;
@property NSMutableArray *NSMutableArray;
@property NSDictionary *NSDictionary;
@property NSMutableDictionary *NSMutableDictionary;
//@property NSValue *NSValue;//一般model不会保有此种类型的属性，故不作考虑
//@property NSDate *NSDate;//一般model不会保有此种类型的属性，故不作考虑
@end
@implementation WGNullValueHelper
@end

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
            value = [self notNullValueWithProperty:properties[i]];
        }
        
        [json setValue:value forKey:propertyName_NSString];
    }
    free(properties);
    
    return json;
}

#pragma mark - model转value时，当值为nil时，转化为默认0值
+ (char *)propertyAttributesPrefixWithAttributes:(const char *)property_attributes{
    size_t len = strlen(property_attributes);
    char *prefix = malloc(len);
    memset(prefix, 0, len);
    memccpy(prefix, property_attributes, ',', len);
    
    return prefix;
}

+ (NSString *)getClassNameWithProperty:(objc_property_t )property{
    
    const char *columnPropertyAttributes = property_getAttributes(property);
    
    //以 ','  号分割的第一个字符串
    char *column_pre = [self propertyAttributesPrefixWithAttributes:columnPropertyAttributes];
    
    u_int outCount;
    objc_property_t *properties  = class_copyPropertyList([WGNullValueHelper class], &outCount);
    
    NSString *type = @"";
    
    for (unsigned int i = 0; i < outCount; i++) {
        const char *tmp = property_getAttributes(properties[i]);
        //以 ','  号分割的第一个字符串
        char *tmp_pre = [self propertyAttributesPrefixWithAttributes:tmp];
        
        if (strcmp(column_pre, tmp_pre)==0) {
            free(tmp_pre);
            type = [NSString stringWithUTF8String:property_getName(properties[i])];
            break;
            
        }else{
            free(tmp_pre);
        }
    }
    
    free(column_pre);
    free(properties);
    
    return type;
}
- (id )notNullValueWithProperty:(objc_property_t )property{
    NSString *className = [[self class] getClassNameWithProperty:property];
    if (className.length==0) {
        WGLogError(@"检测到不支持的属性类型");
        return nil;
    }else{
        if ([NSClassFromString(className) isSubclassOfClass:[NSValue class]]) {
            return @0;//NSValue alloc init后，还是为nil，需要特殊处理
        }else{
            return [[NSClassFromString(className) alloc]init];
        }
    }
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

#pragma mark -
@interface NSData (WGModelValue)
- (instancetype)modelValue;
@end
@implementation NSData (WGModelValue)
- (instancetype )modelValue{
    return self;
}
@end
#pragma mark -
@interface NSDate (WGModelValue)
- (instancetype)modelValue;
@end
@implementation NSDate (WGModelValue)
- (instancetype )modelValue{
    return self;
}
@end


