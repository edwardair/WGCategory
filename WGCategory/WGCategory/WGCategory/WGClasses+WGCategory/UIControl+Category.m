//
//  WGControl+Category.m
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UIControl+Category.h"
@implementation UIControl (Category)
- (UIControl *)copyWithZone:(NSZone *)zone{
    UIControl *newCopy = [super copyWithZone:zone];
    return newCopy;
}

@end
