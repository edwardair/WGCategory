//
//  UIImage+Category.h
//  WuXiAirport
//
//  Created by Apple on 14-3-20.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WGCategory)
/**
 *  修改UIImage 颜色
 *
 *  @param tintColor 需要修改的颜色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

- (UIImage *)roundImageWithRadius:(float )radius;

+ (CGSize )size:(CGSize )size ThatFits:(CGSize)fitSize;
- (UIImage *)scaleTo:(CGFloat )scale;
- (UIImage *)reSizeTo:(CGSize)reSize;
- (UIImage*)imageScaleToMaxSize:(CGSize )maxSize;

- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

+ (UIImage*)captureView:(UIView *)theView;
- (UIImage *)fixOrientationWithImageOrientation:(UIImageOrientation )orientation ;

@end
