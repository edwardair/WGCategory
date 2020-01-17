//
//  UIViewController+WGViewController.m
//  WGCategory
//
//  Created by Apple on 13-12-31.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDevice+WGCategory.h"

#pragma mark - UIViewController
@interface UIViewController()
@end
@implementation UIViewController (WGCategory)
- (void)disableAutoAdjustScrollViewInsets{
    if ([UIDevice isIOS7Version])
        self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)disableExtendedLayoutFull{
    if ([UIDevice isIOS7Version])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}
@end



