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
- (id _Nullable )modelWithClass:(Class _Nullable )modelClass;
/**
 *  生成model
 注意：如果value==nil，则会返回nil，可以使用MODELWITHVALUE(value, class)宏来确保返回非nil
 *
 *  @param className 需要转化的model的类名
 *
 *  @return if value==nil, return nil; else class.instance
 */
- (id _Nullable )modelWithClassName:(NSString *_Nullable)className;
@end

#pragma mark - JSON转Model时，忽略指定字段
@protocol WGJSONModelIgnoreProtocol
@required
- (nonnull NSArray<NSString *> *)wg_excepts;
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
- (NSArray<NSString *> *_Nullable)wg_properties;
- (NSArray<NSString *> *_Nullable)wg_properties:(Class _Nonnull )clazz;
- (BOOL)wg_isPropertyIgnores:(NSString *_Nullable)key;

/**
 *  对存在的model更新数据
 *
 *  @param dic 数据源
 */
- (void)modelUpdateWithData:(NSDictionary *_Nullable)dic;
///**
// *  同上
// *
// *  @param dic 数据源
// *  @param lv  lv==0时，同上方法；此方法为内部使用的，外部一般不需要调用
// */
//- (void)modelUpdateWithData:(NSDictionary *)dic;

- (void)modelMergeFromData:(NSDictionary *_Nullable)dic;
/**
 model与新数据合并，仅更新新数据中存在的字段、并且值不为nil的数据
 ！！！注：如存在子model，子model将重新初始化，而非merge！！！
 ！！！注：如存在子model，子model将重新初始化，而非merge！！！
 ！！！注：如存在子model，子model将重新初始化，而非merge！！！
 @param dic 新数据
 @param clazz 父类
 */
- (void)modelMergeFromData:(NSDictionary *_Nullable)dic inClass:(Class _Nonnull )clazz;

@end




