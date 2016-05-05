//
//  UITextField+WGTextField.h
//  wuxigovapp
//
//  Created by Apple on 14-1-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//


@interface UITextField (WGCategory)
/**
 *@brief UITextField实现NSCopy协议
 *
 *@param 	zone 	NSZone
 *
 *@return	UITextField复制对象
 */
- (id )copyWithZone:(NSZone *)zone;
@end
