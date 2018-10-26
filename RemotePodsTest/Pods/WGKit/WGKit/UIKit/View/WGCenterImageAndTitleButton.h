//
//  WGCenterImageAndTitleButton.h
//  RoidmiFM
//
//  Created by RayMi on 16/7/14.
//  Copyright © 2016年 Roidmi. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  文字图片居中垂直对齐，图片在上
 */
NS_CLASS_AVAILABLE_IOS(8_0) @interface WGCenterImageAndTitleButton : UIButton
/**
 *  图片与文字间的间隔，默认0
 */
@property (nonatomic,assign) IBInspectable CGFloat verticalSpacing;
@end
