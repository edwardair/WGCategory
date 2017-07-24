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


@protocol WGJSONModelProtocol
@optional
/**
 *  生成model
 注意：如果value==nil，则会返回nil，可以使用MODELWITHVALUE(value, class)宏来确保返回非nil
 *
 *  @param modelClass 需要转化的model的类
 *
 *  @return if value==nil, return nil; else class.instance
 */
- (id )modelWithClass:(Class )modelClass;
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



#pragma mark -
@interface NSArray (WGJSONModel)<WGJSONModelProtocol>
@end
#pragma mark -
@interface NSDictionary (WGJSONModel)<WGJSONModelProtocol>
@end
#pragma mark -
@interface NSNull(WGJSONModel)<WGJSONModelProtocol>
@end


#pragma mark - Model
@interface NSObject (WGJSONModel_Append)
/**
 *  对存在的model更新数据
 *
 *  @param dic 数据源
 */
- (void)modelUpdateWithData:(NSDictionary *)dic;
///**
// *  同上
// *
// *  @param dic 数据源
// *  @param lv  lv==0时，同上方法；此方法为内部使用的，外部一般不需要调用
// */
//- (void)modelUpdateWithData:(NSDictionary *)dic;
@end




