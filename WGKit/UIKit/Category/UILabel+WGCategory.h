//
//  UILabel+WGLabel.h
//  wuxigovapp
//
//  Created by Apple on 14-1-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//


#import "UIView+WGCategory.h"

@interface UILabel (WGCategory)
/**
 *@brief UILabel实现NSCopy协议
 *
 *@param 	zone 	NSZone
 *
 *@return	UILabel复制对象
 */
- (id )copyWithZone:(NSZone *)zone;
@end



