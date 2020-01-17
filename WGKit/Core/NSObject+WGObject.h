//
//  WGCategory+NSObject.h
//  WGCategoryAppend
//
//  Created by Apple on 13-12-30.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static inline BOOL isInstanceSelectorConformsToProtocol(Protocol *protocol, SEL _cmd){
    BOOL (^conform)(BOOL , BOOL ) = ^ BOOL (BOOL isRequiredMethod, BOOL isInstanceMethod){
        struct objc_method_description methodDescription = protocol_getMethodDescription(protocol, _cmd, isRequiredMethod, isInstanceMethod);
        return methodDescription.name?YES:NO;
    };
    return conform(NO,YES)?:conform(YES,YES);
}


@interface NSObject(WGObject)

/**
 *  UIAlertView 简化封装
 */
+ (void)alertShowErrorWithMsg:(NSString *)msg;

/**
 *  根据路径 计算文件大小
 *
 *  @param path 文件 绝对路径
 *
 *  @return long 整型
 */
+ (long)mathFileSize:(NSString *)path;

/**
 *  根据路径 计算文件夹大小
 *
 *  @param path 文件夹 绝对路径
 *
 *  @return long整型
 */
+ (long)mathDirSize:(NSString *)path;

/**
 *  注销响应链中的第一响应者
 */
+ (void)resignFirstResponder;

/**
 *  category方式修改系统方法
 *
 *  @param oldSelector  原Class的selector
 *  @param newSelector 修改后的selector
 */
+ (void)swizzleExchangeInstanceAPI:(SEL )oldSelector newSelector:(SEL )newSelector;
+ (void)swizzleExchangeClassAPI:(SEL )oldSelector newSelector:(SEL )newSelector;
+ (BOOL)swizzleAddInstanceAPI:(SEL )newSelector withIMP:(IMP)imp types:(const char *)types;
+ (BOOL)swizzleAddClassAPI:(SEL )newSelector withIMP:(IMP)imp types:(const char *)types;

/**
 *  获取系统语言
 */
+ (NSString *)systemLanguage;
    
    typedef Class(^PropertyClass)(NSString *propertyName);
//+ (PropertyClass) propertyClass;//获取属性的类型
//+ (PropertyClass)propertyClass_NSArray;//获取属性为NSArray类型时，支持的协议名
    + ( Class  )getPropertyClass:(NSString *)property;
    + ( Class )getPropertyClass_NSArray:(NSString *)property;
    @end
