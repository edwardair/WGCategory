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






