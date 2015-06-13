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

#define AutoPropertyNamePrefix @""  //属性前缀
#define PropertyDeclaration(retainType,className,propertyName) ([NSString stringWithFormat:@"@property (nonatomic,%@) %@ *%@;",[self retainTypeFromValue:retainType],className,[AutoPropertyNamePrefix stringByAppendingString:propertyName]])

@implementation NSObject (AutoModelHelper)

#pragma mark  - 检测 此Helper是否支持当前的数据（NSDictionary、NSArray等数据源）
+ (BOOL)isEnableForData:(id)data{
    if ([data isKindOfClass:[NSDictionary class]]) return YES;
    else {
        WGLogFormatError(@"暂不支持\"%@\"的自动化属性申明生成",NSStringFromClass([data class]));
        
        return NO;
    }
}

#pragma mark - 自动生成Model的属性声明
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
 *  @return assign、strong、copy//MARK: 暂时只支持  自动释放环境
 */
+ (NSString *)retainTypeFromValue:(id )value{
    if ([value isKindOfClass:[NSString class]]) {
        return @"copy";
    }
    else
        return @"strong";//一般对象都为string类型
}

+ (void)autoGenerateModelPropertyWithData:(id)data{
    
    if (![self isEnableForData:data]) {
        return;
    }
    
    NSMutableString *property = [NSMutableString stringWithString:@"自动化生成Model属性声明，Model模板可在.h中复制：\n\n"];
    [property appendString:@"@interface ClassName:NSObject\n"];

    if ([data isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *tmp = (NSDictionary *)data;
        
        for (NSString *key in [tmp allKeys]) {
            id value = tmp[key];
            
            NSString *classNameOfValue = [self publicClassNameWithValue:value];
            
            [property appendString:PropertyDeclaration(value, classNameOfValue, key)];
            [property appendString:@"\n"];
        }
        
        [property appendString:@"@end\n"];
        [property appendString:@"@implementation ClassName \n@end"];
        
    }
    else if([data isKindOfClass:[NSArray class]]){
        
        return;
    }
    else {
        
        return;
    }
    
    WGLogMsg(property);
}

#pragma mark - 一键赋值
+ (id )autoSaveValueWithData:(id)data{
    id model = [[[self class] alloc]init];
    [model autoSaveValueWithData:data];
    return model;
}
+ (id)autoSaveValueWithData:(id)data OwnClassName:(NSString *)className{
    id model = [[NSClassFromString(className) alloc]init];
    [model autoSaveValueWithData:data];
    return model;
}

- (void)autoSaveValueWithData:(id)data{
    if (![[self class] isEnableForData:data]) {
        return;
    }
    
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i<count; i++){
        
        const char* propertyName_CStr = property_getName(properties[i]);
        
        NSString *propertyName_NSString = [NSString stringWithFormat:@"%s",propertyName_CStr];//Model属性名称
        NSString *dataKeyString = propertyName_NSString;//数据源中的key
        
        if ([dataKeyString hasPrefix:AutoPropertyNamePrefix]) {
            dataKeyString = [dataKeyString stringByReplacingOccurrencesOfString:AutoPropertyNamePrefix withString:@""];
        }
        //检测value是否为null，如果为null，可能为 字典data中并不存在dataKeyString，不赋值
        id value = [data valueForKey:dataKeyString];
        if (value) {
            [self setValue:value forKey:propertyName_NSString];
        }
    }
    
    free(properties);
    
}

- (NSDictionary *)jsonFromModel{
    NSMutableDictionary *json = @{}.mutableCopy;
    
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++){
        
        const char* propertyName_CStr = property_getName(properties[i]);
        NSString *propertyName_NSString = [NSString stringWithFormat:@"%s",propertyName_CStr];//Model属性名称

        [json setValue:[self valueForKey:propertyName_NSString] forKey:propertyName_NSString];
    }
    free(properties);
    
    return json;
}


@end
