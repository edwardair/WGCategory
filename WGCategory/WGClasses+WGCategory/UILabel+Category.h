//
//  UILabel+WGLabel.h
//  wuxigovapp
//
//  Created by Apple on 14-1-8.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "WGDefines.h"

@interface UILabel (Category)
/**
 *@brief UILabel实现NSCopy协议
 *
 *@param 	zone 	NSZone
 *
 *@return	UILabel复制对象
 */
- (id )copyWithZone:(NSZone *)zone;


@end


#pragma mark - WGLabel Category
@interface WGLabel (Category)
/**
 *  self.text 方法修改，防止，比如 self.text = @1（或者self.text= [NSNull null]）此种方式（网络数据为多），导致程序奔溃，默认null为 WGNull，WGNull所显示内容视各项目不同需求而定，可以为@“空”、@“”等等；
 *
 *  @param text label需要显示的文字，类型可以为任何类型
 */
- (void)setText:(NSString *)text;
@end


