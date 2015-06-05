//
//  NSObject+AutoModelHelper.h
//  WeCommunity
//
//  Created by iOS ZYJ on 14-11-24.
//  Copyright (c) 2014年 Eduoduo. All rights reserved.
//

/*
 Model 模板，可直接复制放在.m中
 
 #pragma mark - 请求到的数据的数据模型
 @interface InformationModel:NSObject
 <
 AutoModelHelperDelegate
 >
 @property (nonatomic,copy) NSString *WGAuto_communitytext;
 @property (nonatomic,copy) NSString *WGAuto_id;
 @property (nonatomic,copy) NSString *WGAuto_communityid;
 @property (nonatomic,copy) NSString *WGAuto_communityname;
 
 @end
 @implementation InformationModel
 @end
 
 */

#import <Foundation/Foundation.h>

/**
 *  Model生成自动化帮助封装
 */
@interface NSObject (AutoModelHelper)

/**
 *  自动打印Model属性申明，简化代码
 *  仅支持NSDictionary
 *  NSDictionary 属性名称为  "WGAuto_"+key
 *  else 打印错误
 */
+ (void)autoGenerateModelPropertyWithData:(id)data;

/**
 *   类 初始化实例后自动赋值
 *  帮助自动化赋值
 *  注意：只有对通过 autoGenerateModelProperty方法 生成的属性才适用
 * return className的实例对象
 */
+ (id)autoSaveValueWithData:(id)data OwnClassName:(NSString *)className;
+ (id)autoSaveValueWithData:(id)data;

/**
*   实例赋值
 *  帮助自动化赋值
 *  注意：只有对通过 autoGenerateModelProperty方法 生成的属性才适用
 */
- (void)autoSaveValueWithData:(id)data;
/**
 *  模型转化为JSON
 */
- (NSDictionary *)jsonFromModel;
@end
