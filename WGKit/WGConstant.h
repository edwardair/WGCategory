//
//  WGCategory+Defines.h
//  WGCategoryAppend 通用宏定义类
//
//  Created by Apple on 13-12-30.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//系统数据
#define ApplicationFrame [[UIScreen mainScreen] applicationFrame]
#define Bounds [[UIScreen mainScreen] bounds]
#define KeyWindow [[UIApplication sharedApplication] keyWindow]


//weakSelf
#define WEAKOBJECT(obj,objName) typeof(obj) __weak objName = obj;
#define WEAKSELF WEAKOBJECT(self,weakSelf);


#pragma mark  - 简化默认初始化代码 -
//super init
#define CouldInitialized_Init \
self = [super init]; \
if(!self) \
return nil;


//super initWithFrame
#define CouldInitialized_InitWithFrame(frame) \
self = [super initWithFrame:frame]; \
if(!self) \
return nil;


//单例
#define WGSHARED_INTERFACE \
+ (instancetype)shared;
#define WGSHARED_IMPLEMENTATION \
+ (instancetype)shared{\
static id instance;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
    instance = [[[self class]alloc]init];\
});\
return instance;\
}


