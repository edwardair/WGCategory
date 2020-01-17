//
//  WGButton+Category.m
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UIButton+WGCategory.h"
#import "UIView+WGCategory.h"

@implementation UIButton (WGCategory)
@end


#pragma mark - UIButton修改为圆角按钮
@implementation RoundButton
- (void)setup{
    [self setCorners:UIRectCornerAllCorners ByRadius:5.f];
    self.clipsToBounds = YES;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self setup];
}
@end
