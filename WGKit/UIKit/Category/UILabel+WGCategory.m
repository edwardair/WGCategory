//
//  UILabel+WGLabel.m
//  wuxigovapp
//
//  Created by Apple on 14-1-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//


#import "WGDefines.h"
#import <objc/runtime.h>
@implementation UILabel (WGCategory)
#pragma mark copy zone
- (id )copyWithZone:(NSZone *)zone{
    UILabel *newView = [super copyWithZone:zone];
    newView.text = self.text;
    newView.numberOfLines = self.numberOfLines;
    newView.textAlignment = self.textAlignment;
    newView.contentMode = self.contentMode;
    newView.font = self.font;
    newView.textColor = self.textColor;
    return newView;
}
@end

