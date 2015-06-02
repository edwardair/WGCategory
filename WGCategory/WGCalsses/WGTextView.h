//
//  WGTextView.h
//  FengYeZhiXiang
//
//  Created by iOS ZYJ on 14-9-3.
//  Copyright (c) 2014年 ___E多多___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGTextView : UITextView
@property (copy, nonatomic) NSString *placeHolder;
@property (nonatomic,strong) NSAttributedString *attributedString;
@end
