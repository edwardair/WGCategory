//
//  UIImageView+WGImageView.h
//
//  Created by Apple on 14-1-15.
//  Copyright (c) 2014年 Apple. All rights reserved.
//


@interface UIImageView (WGCategory)
/**
*@brief UIImageView实现NSCopy协议
*
*@param 	zone 	NSZone
*
*@return	UIImageView复制对象
*/
- (id )copyWithZone:(NSZone *)zone;
@end
