//
//  WGTextView+Category.m
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-28.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UITextView+WGCategory.h"

@implementation UITextView (WGCategory)
#pragma mark copy zone
- (id )copyWithZone:(NSZone *)zone{
    UITextView *newView = [[[self class] allocWithZone:zone] initWithFrame:self.frame];
    newView.text = self.text;
    newView.textAlignment = self.textAlignment;
    newView.textColor = self.textColor;
    newView.delegate = self.delegate;
    newView.keyboardType = self.keyboardType;
    newView.returnKeyType = self.returnKeyType;
    newView.editable = self.editable;
    newView.selectable = self.isSelectable;
    newView.inputAccessoryView = self.inputAccessoryView;
    newView.inputView = self.inputView;
    return newView;
}
@end
