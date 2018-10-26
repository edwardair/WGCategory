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
 @property (nonatomic,copy) NSString *communitytext;
 @property (nonatomic,copy) NSString *id;
 @property (nonatomic,copy) NSString *communityid;
 @property (nonatomic,copy) NSString *communityname;
  @end
 @implementation InformationModel
 @end
*/

/**
 *  某些属性名，比如  description，会跟系统冲突，可以在前面加上此前缀
 
     注意：不能给属性为“另一个子model”加上此字段
 *
 */
#define AutoPropertyNamePrefix @"WGAuto_"

#import <Foundation/Foundation.h>

#pragma mark - 数据转model声明打印
@interface NSArray (GENERATE_DEBUG)
/**
 *  生成model打印
 *
 *  @param key key的大写字母形式为model的类名
 */
- (NSString *)logWithKey:(NSString *)key;
@end

@interface NSDictionary (GENERATE_DEBUG)
/**
 *  生成model打印
 *
 *  @param key key的大写字母形式为model的类名
 */
- (NSString *)logWithKey:(NSString *)key;
@end



