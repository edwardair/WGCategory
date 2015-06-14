//
//  NSObject+AutoModelHelper.m
//  WeCommunity
//
//  Created by iOS ZYJ on 14-11-24.
//  Copyright (c) 2014年 Eduoduo. All rights reserved.
//

#import "NSObject+AutoModelHelper.h"
#import <objc/runtime.h>
#import "WGDefines.h"

#define PropertyDeclaration(value,propertyAttributes,propertyName) ([NSString stringWithFormat:@"@property (nonatomic,%@) %@ *%@;",[NSObject retainTypeFromValue:value],propertyAttributes,propertyName])

@implementation NSObject (AutoModelHelper)
#pragma mark - 数据转model声明打印 辅助方法
/**
 *  将 NSStringFromClass检测出得类名，可能为比如：NSCFString等字样的，转化为NSString公有类名
 *
 *  //MARK: 需要后期一个个添加  特殊情况，持续扩展
 *
 *  @param name NSStringFromClass检测出得类名
 *
 *  @return 公有类名
 */
+ (NSString *)publicClassNameWithName:(NSString *)name{
    //eg:
    if ([name isEqualToString:@"__NSCFString"] ||
        [name isEqualToString:@"__NSCFConstantString"]) {
        return @"NSString";
    }
    else if ([name isEqualToString:@"__NSCFNumber"]){
        return @"NSNumber";
    }
    else if ([name isEqualToString:@"__NSArrayM"]){
        return @"NSArray";
    }
    else if ([name isEqualToString:@"__NSDictionaryM"]){
        return @"NSDictionary";
    }
    else if ([name isEqualToString:@"__NSArrayI"]){
        return @"NSArray";
    }
    
    return name;
}
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
    else if ([value isKindOfClass:[NSNumber class]]){
        return @"NSNumber";
    }
    else
        return @"NSString";
    
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

#pragma mark - 通用model类型转化为value
- (id )valueFromModel{
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
        value = [value valueFromModel];
        
        [json setValue:value forKey:propertyName_NSString];
    }
    free(properties);
    
    return json;
}


@end

#pragma mark - 数据转model声明打印
@implementation NSArray (GENERATE_DEBUG)
- (NSString *)logWithKey:(NSString *)key{
    return [self logWithKey:key Level:0];
}

- (NSString *)logWithKey:(NSString *)key Level:(int )level{
    key = [[NSString handleNetString:key] uppercaseString];
    key = [NSString stringWithFormat:@"%@_%d",key,level];
    
    for (id obj in self) {
        
        if ([obj respondsToSelector:@selector(logWithKey:Level:)]) {
            [obj logWithKey:key Level:level+1];
        }
        
        break;
    }
    
    return @"NSArray";
}
@end

#pragma mark -
@implementation NSDictionary (GENERATE_DEBUG)
- (NSString *)logWithKey:(NSString *)key{
    return [self logWithKey:key Level:0];
}

- (NSString *)logWithKey:(NSString *)key Level:(int )level{
    
    key = [[NSString handleNetString:key] uppercaseString];
    
    NSMutableString *property = [NSMutableString stringWithString:@"\n\n\n"];
    [property appendFormat:@"@interface %@:NSObject\n",key];
    
    for (NSString *k in [self allKeys]) {
        id value = self[k];
        
        //属性原始类型名称
        NSString *propertyAttributes = [NSObject publicClassNameWithValue:value];

        //如果value可实现logWithKey方法，则调用
        if ([value respondsToSelector:@selector(logWithKey:Level:)]) {
           propertyAttributes = [value logWithKey:[NSString stringWithFormat:@"%@_%@",key,k] Level:level+1];
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

#pragma mark - value转model
@implementation NSArray (JsonToModel)
- (id )valueToModelWithModelClassName:(NSString *)propertyAttributeName{
    return [self valueToModelWithModelClassName:propertyAttributeName Level:0];
}
- (id )valueToModelWithModelClassName:(NSString *)propertyAttributeName Level:(int )level{
    
    propertyAttributeName = [NSString stringWithFormat:@"%@_%d",propertyAttributeName,level];
    propertyAttributeName = [propertyAttributeName uppercaseString];
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        if (![obj respondsToSelector:@selector(valueToModelWithModelClassName:Level:)]) {
            
            //如果条件成立，则直接返回self，不做model转化
            return self;
            
        }else{
            [models addObject:[obj valueToModelWithModelClassName:propertyAttributeName Level:level+1]];
        }
    }
    
    return models;
}
@end

#pragma mark -
@implementation NSDictionary (JsonToModel)
- (id )valueToModelWithModelClassName:(NSString *)className{
    return [self valueToModelWithModelClassName:className Level:0];
}
- (id )valueToModelWithModelClassName:(NSString *)className Level:(int )level{
    
    Class class = NSClassFromString([className uppercaseString]);
    if (!class) {
        //如果class不存在，则直接返回self
        return self;
    }
    
    id model = [[class alloc]init];
    
    u_int count;
    objc_property_t *properties  = class_copyPropertyList(class, &count);
    
    for (int i = 0; i<count; i++){
        
        //model属性名
        const char* propertyName_CStr = property_getName(properties[i]);
        NSString *propertyName_NSString = [NSString stringWithFormat:@"%s",propertyName_CStr];
        
        //数据源中的key
        NSString *dataKeyString = propertyName_NSString;
        if (AutoPropertyNamePrefix.length && [dataKeyString hasPrefix:AutoPropertyNamePrefix]) {
            dataKeyString = [dataKeyString stringByReplacingOccurrencesOfString:AutoPropertyNamePrefix withString:@""];
        }
        
        id value = self[dataKeyString];
        
        //检测value是否为null，跳过此value的赋值
        if (value) {
            
            if ([value respondsToSelector:@selector(valueToModelWithModelClassName:Level:)]) {
                //需要递归转化model
                value = [value valueToModelWithModelClassName:[NSString stringWithFormat:@"%@_%@",className,propertyName_NSString] Level:level+1];
            }
            
            [model setValue:value forKey:propertyName_NSString];
        }
    }
    
    free(properties);

    return model;
}

@end


#pragma mark - model转value
#pragma mark - model转value
@interface NSArray (WGModelToJson)
- (instancetype)valueFromModel;
@end
@interface NSDictionary (WGModelToJson)
- (instancetype)valueFromModel;
@end
@interface NSString (WGModelToJson)
- (instancetype)valueFromModel;
@end
@interface NSNumber (WGModelToJson)
- (instancetype)valueFromModel;
@end
@interface NSValue (WGModelToJson)
- (instancetype)valueFromModel;
@end

@implementation NSArray (WGModelToJson)
- (instancetype )valueFromModel{
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        [tmp addObject:[obj valueFromModel]];
    }
    return tmp;
}
@end
#pragma mark -
@implementation NSDictionary (WGModelToJson)
- (instancetype )valueFromModel{
    return self;
}
@end
#pragma mark -
@implementation NSString (WGModelToJson)
- (instancetype )valueFromModel{
    return self;
}
@end
#pragma mark -
@implementation NSNumber (WGModelToJson)
- (instancetype )valueFromModel{
    return self;
}
@end
#pragma mark -
@implementation NSValue (WGModelToJson)
- (instancetype )valueFromModel{
    return self;
}
@end



