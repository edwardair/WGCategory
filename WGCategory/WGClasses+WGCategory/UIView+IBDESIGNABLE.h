//
//  UIView+IBDESIGNABLE.h
//  WGCategory
//
//  Created by RayMi on 15/8/19.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (IBDESIGNABLE)
@property (nonatomic,assign) IBInspectable CGFloat boardWidth;
@property (nonatomic,assign) IBInspectable UIColor *boardColor;
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@end

