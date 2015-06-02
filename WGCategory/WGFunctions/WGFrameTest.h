//
//  WGFrameTest.h
//  WGCategory
//
//  Created by Apple on 13-12-31.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define InFrameTestMode//宏定义  开启frameTest测试view，若不开启或者发布时，需要注释掉此定义
#ifdef InFrameTestMode
#warning @"frameTest模式开启，注意当为发布版本时，需要将此定义注释掉"

#define ReplaceViewControllerMethod_ViewWillAppear \
[UIViewController replaceSystemAPI:[UIViewController class] OriginSelector:@selector(viewWillAppear:) ReplaceSelector:@selector(WGViewWillAppear:)];\

#endif



/**
 *  可使用此类，查看所需要的视图的frame，并支持修改frame，需要顶部宏定义将“#define InFrameTestMode”注释出来
 */
@interface WGFrameTest : UIControl
/**
*@brief	touches began 中 修改为YES，end中修改为NO，判断是否处于触摸状态 ，yes时，禁用所有gestureRecognize
*/
@property (nonatomic) BOOL isTouchesBegan;
/**
*@brief	根据传入的vc，将self添加当前vc视图中
*
*@param 	vc 当前界面所显示的视图控制器
*
*/
+ (void)shareFrameTestWithViewController:(UIViewController *)vc;
/**
*@brief	获取单例
*
*@return	FrameTestView
*/
+ (WGFrameTest *)shareFrameTest;
/**
*@brief	当 UIView添加到父类并且运行到drawRect时，方法中自调用此方法，将self移到视图的最上层
*
*/
+ (void)bringTestViewToFront;
@end





