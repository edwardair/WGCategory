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

#define AutoPropertyNamePrefix @""  //属性前缀，可以任意自定义

#import <Foundation/Foundation.h>

/**
 *  Model生成自动化帮助封装
 */
@interface NSObject (AutoModelHelper)

/**
*  自动打印Model属性申明，简化代码
*  支持字典、数组
 
   注意：当data为数组时，一般服务器获取的数组中，每个value的数据结构是相同的，故默认只取第一个obj
        如有额外情况，使用+autoFullGenerateModelPropertyWithData
 
*  @param data      OC对象
*  @param className 当前data的model类名
*/
+ (void)autoGenerateModelPropertyWithData:(id)data ClassName:(NSString *)className;
/**
 *  同上
 
 *  如果data为数组，则将所有value都尝试转化为model声明
 */
+ (void)autoFullGenerateModelPropertyWithData:(id)data ClassName:(NSString *)className;

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
