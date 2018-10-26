//
//  NSObject+WGJSONModel.m
//  WGCategory
//
//  Created by RayMi on 15/6/15.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "NSObject+WGJSONModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "WGDefines.h"

#pragma mark - NSArray
@implementation NSArray (WGJSONModel)
- (id)modelWithClass:(Class)modelClass{
    return [self modelWithClassName:NSStringFromClass(modelClass)];
}
- (id )modelWithClassName:(NSString *)propertyAttributeName{
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        if (![obj respondsToSelector:@selector(modelWithClassName:)]) {
            //如果条件成立，则直接返回self，不做model转化
            return self;
        }else{
            [models addObject:[obj modelWithClassName:propertyAttributeName]];
        }
    }
    return models;
}
@end


#pragma mark - NSDictionary
@implementation NSDictionary (WGJSONModel)
- (id)modelWithClass:(Class)modelClass{
    return [self modelWithClassName:NSStringFromClass(modelClass)];
}
- (id )modelWithClassName:(NSString *)className{
    Class modelClass = NSClassFromString(className);
    if (!modelClass) {
        //如果class不存在，则直接返回self
        return self;
    }
    id model = [[modelClass alloc]init];
    [model modelUpdateWithData:self];
    return model;
}
@end
#pragma mark - NSNull
@implementation NSNull (WGJSONModel)
- (id)modelWithClass:(Class)modelClass{
    return [self modelWithClassName:NSStringFromClass(modelClass)];
}
- (id )modelWithClassName:(NSString *)className{
    Class modelClass = NSClassFromString(className);
    if (!modelClass) {
        //如果class不存在，则直接返回self
        return self;
    }
    id model = [[modelClass alloc]init];
    return model;
}
@end


#pragma mark - Model
@implementation NSObject (WGJSONModel_Append)
- (void)modelUpdateWithData:(NSDictionary *)dic{
    [self modelUpdateWithData:dic inClass:[self class]];
}
- (void)modelUpdateWithData:(NSDictionary *)dic inClass:(Class )class{
    //如果父类非NSObject，则递归
    Class superclass = class_getSuperclass(class);
    if(![superclass isEqual:[NSObject class]]){
        [self modelUpdateWithData:dic inClass:superclass];
    }
    u_int count;
    objc_property_t *properties  = class_copyPropertyList(class, &count);
    for (int i = 0; i<count; i++){
        //model属性名
        const char* propertyName_CStr = property_getName(properties[i]);
        NSString *propertyName_NSString = [NSString stringWithFormat:@"%s",propertyName_CStr];
        //数据源中的key
        NSString *dataKeyString = [NSString stringWithString:propertyName_NSString];
        if (AutoPropertyNamePrefix.length && [dataKeyString hasPrefix:AutoPropertyNamePrefix]) {
            dataKeyString = [dataKeyString stringByReplacingOccurrencesOfString:AutoPropertyNamePrefix withString:@""];
        }
        
        id value = dic[dataKeyString];
        //value不能为NSNull类型，而只为nil是安全的
        if ([value isEqual:[NSNull null]]) {
            value = nil;
        }
        //检测value是否为null，跳过此value的赋值
        if (value) {
            //需要递归转化model
            if ([value conformsToProtocol:@protocol(WGJSONModelProtocol)]) {
                //如果属性为NSArray，则检测是否引用某协议，此协议名字即为所使用的类名
                if ([value isKindOfClass:[NSArray class]]) {
                    Class valueClass = class.propertyClass_NSArray(propertyName_NSString);
                    if (class) {
                        value = [value modelWithClass:valueClass];
                    }
                }else{
                    Class valueClass = class.propertyClass(propertyName_NSString);
                    value = [value modelWithClass:valueClass];
                }
            }
            [self setValue:value forKey:propertyName_NSString];
        }else{
            //MARK：value=nil时，可以直接安全设置，详情见-[WGObject setNilValueForKey:]
            //value为空时，同样需要将value赋给self.xxx，以确保将self所带的数据覆盖掉
            [self setValue:value forKey:propertyName_NSString];
        }
    }
    free(properties);
}
@end
