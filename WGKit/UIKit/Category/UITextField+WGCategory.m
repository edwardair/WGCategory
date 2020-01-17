//
//  UITextField+WGTextField.m
//  wuxigovapp
//
//  Created by Apple on 14-1-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UITextField+WGCategory.h"
@implementation UITextField (WGCategory)
#pragma mark copy zone
- (id )copyWithZone:(NSZone *)zone{
    UITextField *newView = [super copyWithZone:zone];
    newView.text = self.text;
    newView.textAlignment = self.textAlignment;
    newView.textColor = self.textColor;
    newView.delegate = self.delegate;
    newView.keyboardType = self.keyboardType;
    newView.returnKeyType = self.returnKeyType;
    newView.placeholder = self.placeholder;
    newView.clearsOnBeginEditing = self.clearsOnBeginEditing;
    newView.inputAccessoryView = self.inputAccessoryView;
    newView.inputView = self.inputView;
    return newView;
}
@end
