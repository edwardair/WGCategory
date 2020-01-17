//
//  NSObject+WGModelValue.m
//  WGCategory
//
//  Created by RayMi on 15/6/15.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "NSObject+WGModelValue.h"
#import "NSObject+WGJSONModel.h"
#import "NSObject+WGAutoModelHelper.h"
#import "WGLog.h"
#import "NSArray+Map.h"
#import <objc/runtime.h>
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

#pragma mark - WGModelValueKeysFilter
@implementation NSString (WGModelValueKeysFilterProtocol)
- (NSArray<NSString *> *)wg_filterKeys {
    return @[self];
}
@end
@implementation NSDictionary (WGModelValueKeysFilterProtocol)
- (NSArray<NSString *> *)wg_filterKeys {
    return self.allKeys;
}
@end
@implementation NSArray (WGModelValueKeysFilterProtocol)
- (NSArray<NSString *> *)wg_filterKeys {
    //使用NSSet去重
    NSMutableSet<NSString *> *tmp = [NSMutableSet set];
    for (id v in self) {
        [tmp addObjectsFromArray:[v wg_filterKeys]];
    }
    return tmp.objectEnumerator.allObjects;
}
- (NSArray<WGModelValueKeysFilterProtocol> * _Nullable)wg_filterKeys_next:(NSString *)curKey {
    for (id v in self) {
        if ([v isEqual:curKey]) {
            return nil;
        }else if ([v isKindOfClass:[NSDictionary class]]) {
            for (NSString *nextKey in [v allKeys]) {
                if ([nextKey isEqualToString:curKey]) {
                    id value = ((NSDictionary *)v)[nextKey];
                    if ([value isKindOfClass:[NSArray class]]) {
                        return value;
                    }else {
                        return [value wg_filterKeys];
                    }
                }
            }
        }
    }
    return nil;
}
@end
@implementation NSObject (WGModelValueKeysFilterProtocol)
- (NSArray<NSString *> *)wg_filterKeys {
    return @[];
}
@end

#pragma mark -
@implementation NSObject (WGModelValue)
- (id )modelValue{
    return [self modelValueForKeys:nil];
}
- (id )modelValueForKeys:(NSArray<WGModelValueKeysFilterProtocol> *)keys {
    return [self modelValueWithClass:[self class] onlyThese:keys];
}
- (id )modelValueWithClass:(Class)aClazz onlyThese:(NSArray<WGModelValueKeysFilterProtocol> *)keys{
    //此处方法如被调用，则可以视为self为model，否则会走各自基本类型的方法
    NSMutableDictionary *json = @{}.mutableCopy;
    
    Class superclass = class_getSuperclass(aClazz);
    if(![superclass isEqual:[NSObject class]]){
        [json addEntriesFromDictionary:[self modelValueWithClass:superclass onlyThese:keys]];
    }

    u_int count;
    objc_property_t *properties  = class_copyPropertyList(aClazz, &count);
    for (int i = 0; i<count; i++){
        
        const char* propertyName_CStr = property_getName(properties[i]);
        
        //model属性名
        NSString *propertyName_NSString = [NSString stringWithFormat:@"%s",propertyName_CStr];
        
        //检测是否忽略指定字段
        if ([self wg_isPropertyIgnores:propertyName_NSString]) {
            continue;
        }
        
        NSArray<NSString *> *flattenKeys = [keys wg_filterKeys];
        if (flattenKeys.count && ![flattenKeys containsObject:propertyName_NSString]) {
            continue;//不需要的字段，直接忽略
        }

        id value = [self valueForKey:propertyName_NSString];
        
        //将value深层转化
        value = [value modelValueForKeys:[keys wg_filterKeys_next:propertyName_NSString]];
        
        //确保value不是null
        if (!value) {
            value = [self notNullValueWithProperty:properties[i]];
        }
        
        //真实字段名
        NSString *realPropertyName = propertyName_NSString;
        //处理字段前缀
        if (AutoPropertyNamePrefix.length && [realPropertyName hasPrefix:AutoPropertyNamePrefix]) {
            realPropertyName = [realPropertyName stringByReplacingOccurrencesOfString:AutoPropertyNamePrefix withString:@""];
        }
        [json setValue:value forKey:realPropertyName];
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
@end
@implementation NSArray (WGModelValue)
- (instancetype )modelValueForKeys:(NSArray<WGModelValueKeysFilterProtocol> *)keys {
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        [tmp addObject:[obj modelValueForKeys:keys]];
    }
    return tmp;
}
@end

#pragma mark -
@interface NSDictionary (WGModelValue)
@end
@implementation NSDictionary (WGModelValue)
- (instancetype )modelValueForKeys:(NSArray<WGModelValueKeysFilterProtocol> *)keys{
    NSArray<NSString *> *flattenKeys = [keys wg_filterKeys];
    NSArray *needKeys = self.allKeys;
    if (flattenKeys.count) {
        needKeys = [needKeys wg_map:^NSString * _Nonnull(NSString *  _Nonnull obj, NSUInteger idx) {
            return [flattenKeys containsObject:obj] ? obj : nil;
        }];
    }
    NSMutableDictionary *result = @{}.mutableCopy;
    for (NSString *key in needKeys) {
        [result setObject:[self[key] modelValueForKeys:[keys wg_filterKeys_next:key]] forKey:key];
    }
    return result;
}
@end

#pragma mark -
@interface NSString (WGModelValue)
@end
@implementation NSString (WGModelValue)
- (instancetype )modelValueForKeys:(NSArray<WGModelValueKeysFilterProtocol> *)keys{
    return self;
}
@end

#pragma mark -
@interface NSNumber (WGModelValue)
@end
@implementation NSNumber (WGModelValue)
- (instancetype )modelValueForKeys:(NSArray<WGModelValueKeysFilterProtocol> *)keys{
    return self;
}
@end

#pragma mark -
@interface NSValue (WGModelValue)
@end
@implementation NSValue (WGModelValue)
- (instancetype )modelValueForKeys:(NSArray<WGModelValueKeysFilterProtocol> *)keys{
    return self;
}
@end

#pragma mark -
@interface NSData (WGModelValue)
@end
@implementation NSData (WGModelValue)
- (instancetype )modelValueForKeys:(NSArray<WGModelValueKeysFilterProtocol> *)keys{
    return self;
}
@end
#pragma mark -
@interface NSDate (WGModelValue)
@end
@implementation NSDate (WGModelValue)
- (instancetype )modelValueForKeys:(NSArray<WGModelValueKeysFilterProtocol> *)keys{
    return self;
}
@end


