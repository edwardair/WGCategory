//
//  WGCategory+Defines.h
//  WGCategoryAppend 通用宏定义类
//
//  Created by Apple on 13-12-30.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CGPointExtension.h"

#import "WGFrameTest.h"
#import "WGLog.h"
#import "WGTextInputAccessoryView.h"

#import "WGControl.h"
#import "WGLabel.h"
#import "WGCoreTextView.h"
#import "WGActionSheet.h"
#import "WGAlertView.h"
#import "WGCheckBox.h"
#import "WGTextView.h"
#import "WGPopoverView.h"

#import "NSObject+WGObject.h"
#import "UIView+Category.h"
#import "NSString+WGString.h"
#import "NSTimer+WGTimer.h"
#import "UIGestureRecognizer+Category.h"
#import "UILabel+Category.h"
#import "UIImageView+Category.h"
#import "UIControl+Category.h"
#import "UIButton+Category.h"
#import "UITextField+Category.h"
#import "UITextView+Category.h"
#import "UIViewController+Category.h"
#import "UIDevice+Category.h"
#import "UIImage+Category.h"
#import "NSDate+Category.h"
#import "UIActionSheet+WGActionSheet.h"
#import "UIColor+WGColor.h"
#import "NSObject+AutoModelHelper.h"
#import "NSObject+WGJSONValue.h"

#pragma mark -  WGNull 默认当前项目 字符串空值时，使用什么字符串显示UI -
//当网络客户端时，往往需要检查服务器返回的string是否为空（null），当为null时，返回@“空”，可根据实际项目需求修改
#define WGNull @""

#pragma mark - 系统数据 -
//applicationFrame
#define ApplicationFrame [[UIScreen mainScreen] applicationFrame]
//bounds
#define Bounds [[UIScreen mainScreen] bounds]
//keyWindow
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

#pragma mark - 单例
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













