//
//  WGCategory+Defines.h
//  WGCategoryAppend 通用宏定义类
//
//  Created by Apple on 13-12-30.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CGPointExtension/CGPointExtension.h"

#import "WGFunctions/WGFrameTest.h"
#import "WGFunctions/WGLog.h"
#import "WGFunctions/WGTextInputAccessoryView.h"

#import "WGCalsses/WGControl.h"
#import "WGCalsses/WGLabel.h"
#import "WGCalsses/WGCoreTextView.h"
#import "WGCalsses/WGActionSheet.h"
#import "WGCalsses/WGAlertView.h"
#import "WGCalsses/WGCheckBox.h"
#import "WGCalsses/WGTextView.h"
#import "WGCalsses/WGPopoverView.h"


#import "WGClasses+WGCategory/NSObject+WGObject.h"
#import "WGClasses+WGCategory/UIView+Category.h"
#import "WGClasses+WGCategory/NSString+WGString.h"
#import "WGClasses+WGCategory/NSTimer+WGTimer.h"
#import "WGClasses+WGCategory/UIGestureRecognizer+Category.h"
#import "WGClasses+WGCategory/UILabel+Category.h"
#import "WGClasses+WGCategory/UIImageView+Category.h"
#import "WGClasses+WGCategory/UIControl+Category.h"
#import "WGClasses+WGCategory/UIButton+Category.h"
#import "WGClasses+WGCategory/UITextField+Category.h"
#import "WGClasses+WGCategory/UITextView+Category.h"
#import "WGClasses+WGCategory/UIViewController+Category.h"
#import "WGClasses+WGCategory/UIDevice+Category.h"
#import "WGClasses+WGCategory/UIImage+Category.h"
#import "WGClasses+WGCategory/NSDate+Category.h"
#import "WGClasses+WGCategory/UIActionSheet+WGActionSheet.h"
#import "WGClasses+WGCategory/UIColor+WGColor.h"
#import "WGClasses+WGCategory/NSObject+AutoModelHelper.h"


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












