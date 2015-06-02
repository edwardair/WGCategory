//
//  UILabel+WGLabel.m
//  wuxigovapp
//
//  Created by Apple on 14-1-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//


#import "WGDefines.h"
@implementation UILabel (Category)

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


#pragma mark - WGLabel Category
@implementation WGLabel (Category)
- (void)setText:(NSString *)text{
    NSString *text_ = [NSString  handleNetString:text];
    
    [super setText:text_];
    
}
@end

