//
//  CheckBox.h
//  wuxi
//
//  Created by Apple on 13-7-18.
//  Copyright (c) 2013年 gitmac. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	@brief	checkBox touchesEnd回调方法
 *
 *	@param 	^BoxTouchesEnd 	block
 */
@class WGCheckBox;
typedef void (^BoxTouchesEnd)(WGCheckBox *checkBox);

@interface WGCheckBox : UIControl
@property (nonatomic,retain) UIImage *image;
@property (nonatomic,retain) UIImage *highlightImage;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,retain) WGCheckBox *appendConnectBox;
@property (nonatomic,strong) BoxTouchesEnd boxTouchesEnd;


@property (nonatomic,readonly) UILabel *titleLabel;

/**
 *  当appendConnectBox存在时，当前点击的WGCheckBox更新状态后，强制修改其他Box的状态
 *  注意不能修改box.isSelected来替换，会引起循环引用
 */
- (void)updateOtherConnectBoxState:(BOOL)select;

@end


