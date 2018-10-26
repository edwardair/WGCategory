//
//  WGTextInputAccessoryView.h
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-28.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WGTextInputAccessoryView : UIView

@property (nonatomic) CGFloat topInvalidHeight;//顶部 无效点击区域，一般为导航栏高度或者0
//@property (nonatomic) CGFloat bottomInvalidHeight;//底部 无效点击区域，一般为0

+ (id )shareInputAccessoryView;
@end
