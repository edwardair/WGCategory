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

#define AutoPropertyNamePrefix @""  //属性前缀，不能更改
#define PropertyDeclaration(value,propertyAttributes,propertyName) ([NSString stringWithFormat:@"@property (nonatomic,%@) %@ *%@;",[NSObject retainTypeFromValue:value],propertyAttributes,[AutoPropertyNamePrefix stringByAppendingString:propertyName]])

@implementation NSObject (AutoModelHelper)

#pragma mark  - 检测 此Helper是否支持当前的数据（NSDictionary、NSArray等数据源）
//+ (BOOL)isEnableForData:(id)data{
//    if ([data isKindOfClass:[NSDictionary class]]) return YES;
//    else {
//        WGLogFormatError(@"暂不支持\"%@\"的自动化属性申明生成",NSStringFromClass([data class]));
//        
//        return NO;
//    }
//}

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
//+ (void)autoGenerateModelPropertyWithData:(id)data ClassName:(NSString *)className{
//    [self autoGenerateModelPropertyWithData:data ClassName:className Full:NO];
//}
//+ (void)autoFullGenerateModelPropertyWithData:(id)data ClassName:(NSString *)className{
//    [self autoGenerateModelPropertyWithData:data ClassName:className Full:YES];
//}
//
//+ (void)autoGenerateModelPropertyWithData:(id)data ClassName:(NSString *)className Full:(BOOL )full{
//    
//    NSMutableString *property = [NSMutableString stringWithString:@"\n\n\n"];
//    [property appendFormat:@"@interface %@:NSObject\n",className];
//    
//    if ([data isKindOfClass:[NSDictionary class]]) {
//        
//        NSDictionary *tmp = (NSDictionary *)data;
//        
//        for (NSString *key in [tmp allKeys]) {
//            id value = tmp[key];
//            
//            NSString *classNameOfValue = [self publicClassNameWithValue:value];
//            
//            if ([value isKindOfClass:[NSArray class]]) {
//                //如果属性对应的数据为数组，则尝试检测value的子数据是否能转化为Model的属性打印
//                [self autoGenerateModelPropertyWithData:value ClassName:[key uppercaseString]];
//            }else if([value isKindOfClass:[NSDictionary class]]){
//                //字典需要转化为属性打印，并且在data打印前面
//                [self autoGenerateModelPropertyWithData:value ClassName:[key uppercaseString]];
//
//                //如果value为字典，则此字典将会生成一个字典，属性名相应替换为key的大写状态
//                classNameOfValue = [key uppercaseString];
//                
//            }else{
//                //...其他类型，暂时不做处理
//            }
//            
//            [property appendString:PropertyDeclaration(value, classNameOfValue, key)];
//            [property appendString:@"\n"];
//        }
//        
//        [property appendString:@"@end\n"];
//        [property appendFormat:@"@implementation %@ \n@end\n\n\n",className];
//        
//    }
//    else if([data isKindOfClass:[NSArray class]]){
//        //如果为数组，遍历数组每一个value，尝试转化为Model属性打印
//        for (id obj in data) {
//            [self autoGenerateModelPropertyWithData:obj ClassName:[NSString stringWithFormat:@"%@_Array",className]];
//            //MARK: 一般服务器获取的数组中，每个value的数据结构是相同的，故只取第一个obj
//            //如有额外情况，将break注释即可
//            break;
//        }
//    }
//    else {
//        //如果非字典、数组的其他类型，一般都是类似NSString的基本类型，忽略
//    }
//    
//    //只有字典类型才生成model
//    if ([data isKindOfClass:[NSDictionary class]]) {
//        WGLogMsg(property);
//    }
//}

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

- (void)autoSaveValueWithData:(NSDictionary *)data{
//    if (![[self class] isEnableForData:data]) {
//        return;
//    }
    
    
    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i<count; i++){
        
        const char* propertyName_CStr = property_getName(properties[i]);
        
        NSString *propertyName_NSString = [NSString stringWithFormat:@"%s",propertyName_CStr];//Model属性名称
        NSString *dataKeyString = propertyName_NSString;//数据源中的key
        
        if ([dataKeyString hasPrefix:AutoPropertyNamePrefix]) {
            dataKeyString = [dataKeyString stringByReplacingOccurrencesOfString:AutoPropertyNamePrefix withString:@""];
        }
        //检测value是否为null，默认不赋值
        id value = [data valueForKey:dataKeyString];
        if (value) {
            
            //如果value为字典，获取 propertyName_NSString大写后的类
            if ([value isKindOfClass:[NSDictionary class]]) {
                Class valueClass = NSClassFromString([propertyName_NSString uppercaseString]);
                if (valueClass!=Nil) {
                    //如果类存在，则将value指向此类的实例对象
                    value = [valueClass autoSaveValueWithData:value];
                }
            }else if ([value isKindOfClass:[NSArray class]]){
                NSArray *value_tmp = [NSArray arrayWithArray:value];
                
                NSString *subClassName = [[propertyName_NSString uppercaseString] stringByAppendingString:@"_Array"];
                Class subClass = NSClassFromString(subClassName);
               
                //如果value是数组，则检测  propertyName_NSString+"_Array" 的类是否存在，存在，则将所有子数组转化为model
                if (subClass!=Nil) {
                    //value重新指向为 所有子数据的容器
                    value = [NSMutableArray arrayWithCapacity:value_tmp.count];
                    
                    for (id value_tmp_sub in value_tmp) {
                        [value addObject:[subClass autoSaveValueWithData:value_tmp_sub]];
                    }
                }
                
            }else{
                //...不做处理,value保持不变
            }
            
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






#pragma mark -
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
        if ([value respondsToSelector:@selector(logWithKey:)]) {
           propertyAttributes = [value logWithKey:[NSString stringWithFormat:@"%@_%@",key,k]];
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

@implementation NSArray (JsonToModel)
- (instancetype)jsonToModelWithModelClassName:(NSString *)propertyAttributeName{
    return [self jsonToModelWithModelClassName:propertyAttributeName Level:0];
}
- (instancetype)jsonToModelWithModelClassName:(NSString *)propertyAttributeName Level:(int )level{
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        if (![obj respondsToSelector:@selector(jsonToModelWithModelClassName:Level:)]) {
            
            //如果条件成立，则直接返回self，不做model转化
            return self;
            
        }else{
            [models addObject:[obj jsonToModelWithModelClassName:propertyAttributeName Level:level+1]];
        }
    }
    
    return models;
}
@end
@implementation NSArray (ModelToJson)
@end

@implementation NSDictionary (JsonToModel)
- (id )jsonToModelWithModelClassName:(NSString *)className{
    return [self jsonToModelWithModelClassName:className Level:0];
}
- (id )jsonToModelWithModelClassName:(NSString *)className Level:(int )level{
    
    Class class = NSClassFromString(className);
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
            
            if ([value respondsToSelector:@selector(jsonToModelWithModelClassName:Level:)]) {
                //需要递归转化model
                value = [value jsonToModelWithModelClassName:propertyName_NSString Level:level+1];
            }
            
            [self setValue:value forKey:propertyName_NSString];
        }
    }
    
    free(properties);

    return model;
}

@end
@implementation NSDictionary (ModelToJson)

@end




