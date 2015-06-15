//
//  NSObject+WGJSONModel.h
//  WGCategory
//
//  Created by RayMi on 15/6/15.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

//当value 不确定是否==nil时，使用此宏定义，始终返回class对应的实例对象，确保返回的model!=nil
#define MODELWITHVALUE(value, class)                                           \
({                                                                           \
id model = [value modelWithClass:class];                                   \
if (!model)                                                                \
model = [[class alloc] init];                                            \
model;                                                                     \
})

/**
 *  NSDictionary、NSArray转model
 */
@interface NSObject (WGJSONModel)
/**
 *  生成model
 注意：如果value==nil，则会返回nil，可以使用MODELWITHVALUE(value, class)宏来确保返回非nil
 *
 *  @param class 需要转化的model的类
 *
 *  @return if value==nil, return nil; else class.instance
 */
- (id )modelWithClass:(Class )class;
/**
 *  生成model
 注意：如果value==nil，则会返回nil，可以使用MODELWITHVALUE(value, class)宏来确保返回非nil
 *
 *  @param className 需要转化的model的类名
 *
 *  @return if value==nil, return nil; else class.instance
 */
- (id )modelWithClassName:(NSString *)className;
@end
