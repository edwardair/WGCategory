//
//  NSObject+WGJSONModel.m
//  WGCategory
//
//  Created by RayMi on 15/6/15.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "NSObject+WGJSONModel.h"
#import <objc/runtime.h>
#import "WGDefines.h"
@implementation NSObject (WGJSONModel)
#pragma mark -
- (id)modelWithClass:(Class)modelClass{
    return [self modelWithClassName:NSStringFromClass(modelClass)];
}
- (id )modelWithClassName:(NSString *)className{
    WGLogFormatWarn(@"不支持此类：%@转化为model，仅返回%@的实例对象，不赋值",NSStringFromClass([self class]),className);
    return [[NSClassFromString(className) alloc]init];
}
@end


#pragma mark -
@implementation NSArray (WGJSONModel)
- (id)modelWithClass:(Class)modelClass{
    return [self modelWithClassName:NSStringFromClass(modelClass)];
}
- (id )modelWithClassName:(NSString *)propertyAttributeName{
    return [self modelWithClassName:propertyAttributeName Level:0];
}
- (id )modelWithClassName:(NSString *)propertyAttributeName Level:(int )level{
    
    propertyAttributeName = [NSString stringWithFormat:@"%@_%d",propertyAttributeName,level];
    propertyAttributeName = [propertyAttributeName uppercaseString];
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        if (![obj respondsToSelector:@selector(modelWithClassName:Level:)]) {
            
            //如果条件成立，则直接返回self，不做model转化
            return self;
            
        }else{
            [models addObject:[obj modelWithClassName:propertyAttributeName Level:level+1]];
        }
    }
    
    return models;
}
@end

#pragma mark -
@implementation NSDictionary (WGJSONModel)
- (id)modelWithClass:(Class)modelClass{
    return [self modelWithClassName:NSStringFromClass(modelClass)];
}

- (id )modelWithClassName:(NSString *)className{
    return [self modelWithClassName:className Level:0];
}
- (id )modelWithClassName:(NSString *)className Level:(int )level{
    
    Class modelClass = NSClassFromString([className uppercaseString]);
    if (!modelClass) {
        //如果class不存在，则直接返回self
        return self;
    }
    
    id model = [[modelClass alloc]init];
    
    u_int count;
    objc_property_t *properties  = class_copyPropertyList(modelClass, &count);
    
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
            if ([value respondsToSelector:@selector(modelWithClassName:Level:)]) {
                //需要递归转化model
                value = [value modelWithClassName:[NSString stringWithFormat:@"%@_%@",className,propertyName_NSString] Level:level+1];
            }
            
            [model setValue:value forKey:propertyName_NSString];
        }
    }
    
    free(properties);
    
    return model;
}

@end
