//
//  UIView+IBDESIGNABLE.m
//  WGCategory
//
//  Created by RayMi on 15/8/19.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "UIView+IBDESIGNABLE.h"

@implementation UIView (IBDESIGNABLE)
@dynamic boardColor,boardWidth,cornerRadius;
- (void)setBoardWidth:(CGFloat)boardWidth{
    self.layer.borderWidth = boardWidth;
}
- (void)setBoardColor:(UIColor *)boardColor{
    self.layer.borderColor = boardColor.CGColor;
}
- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
@end
