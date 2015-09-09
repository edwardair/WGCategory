//
//  WGTextView.h
//  FengYeZhiXiang
//
//  Created by iOS ZYJ on 14-9-3.
//  Copyright (c) 2014年 ___E多多___. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface WGTextView : UITextView
@property (copy, nonatomic) IBInspectable NSString *placeHolder;
@property (nonatomic,strong) IBInspectable NSAttributedString *attributedString;
@end
