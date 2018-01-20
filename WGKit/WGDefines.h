//
//  WGCategory+Defines.h
//  WGCategoryAppend 通用宏定义类
//
//  Created by Apple on 13-12-30.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

////Other
//#import "WGTextInputAccessoryView.h"
//#import "WGLabel.h"
//#import "WGCoreTextView.h"
//#import "WGCheckBox.h"
//#import "WGPopoverView.h"
//#import "WGGetGestureSecrets.h"
//#import "WGControl.h"


//Core
#import "WGLog.h"
#import "NSObject+WGObject.h"
#import "NSString+WGString.h"
#import "NSTimer+WGTimer.h"
#import "NSDate+WGCategory.h"
#import "NSObject+WGBlock.h"

//UIKit
#import "WGActionSheet.h"
#import "WGAlertView.h"
#import "WGTextView.h"

#import "UIViewController+WGCategory.h"

#import "UIView+WGCategory.h"
#import "UIView+IBDESIGNABLE.h"

#import "UILabel+WGCategory.h"
#import "UITextField+WGCategory.h"
#import "UITextView+WGCategory.h"

#import "UIControl+WGCategory.h"
#import "UIButton+WGCategory.h"

#import "UIImageView+WGCategory.h"
#import "UIImage+WGCategory.h"

#import "UIGestureRecognizer+WGCategory.h"
#import "UIDevice+WGCategory.h"
#import "UIColor+WGColor.h"

#import "NSArray+Map.h"
#import "NSDictionary+Map.h"

//JSON MODEL
#import "NSObject+WGAutoModelHelper.h"
#import "NSObject+WGJSONValue.h"
#import "NSObject+WGJSONModel.h"
#import "NSObject+WGModelValue.h"
#import "NSArray+WGJSONModel.h"

//WGTableController
#import "WGTableController.h"
#import "UITableView+WGAutoLayout.h"
#import "UITableView+EdgeInsets.h"
#import "UITableViewCell+WGAutoLayout.h"

#pragma mark -  WGNull 默认当前项目 字符串空值时，使用什么字符串显示UI -
//当网络客户端时，往往需要检查服务器返回的string是否为空（null），当为null时，返回@“空”，可根据实际项目需求修改
#define WGNull @""


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


