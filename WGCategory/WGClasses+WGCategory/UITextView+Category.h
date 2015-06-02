//
//  WGTextView+Category.h
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-28.
//  Copyright (c) 2014年 Apple. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "UITextView+Category.h"

@interface UITextView (Category)
/**
 *@brief UITextView实现NSCopy协议
 *
 *@param 	zone 	NSZone
 *
 *@return	UITextView复制对象
 */
- (id )copyWithZone:(NSZone *)zone;

@end
