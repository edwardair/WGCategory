//
//  UIViewController+WGViewController.m
//  WGCategory
//
//  Created by Apple on 13-12-31.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "WGDefines.h"
#import <objc/runtime.h>


#pragma mark - UIViewController
@interface UIViewController()
@end
@implementation UIViewController (WGCategory)

#ifdef InFrameTestMode
#pragma mark - InFrameTestMode frame测试模式

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewWillAppear:(BOOL)animated{
    [WGFrameTest shareFrameTestWithViewController:self];
}
#pragma clang diagnostic pop

#endif

- (void)disableAutoAdjustScrollViewInsets{
    if ([UIDevice isIOS7Version])
        self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)disableExtendedLayoutFull{
    if ([UIDevice isIOS7Version])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}

@end



