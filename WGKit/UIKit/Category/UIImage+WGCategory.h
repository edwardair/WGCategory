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
- (UIImage *_Nonnull)wg_imageWithTintColor:(UIColor *_Nonnull)tintColor;

- (UIImage *_Nonnull)roundImageWithRadius:(float )radius;

+ (CGSize )size:(CGSize )size ThatFits:(CGSize)fitSize;
- (UIImage *_Nonnull)scaleTo:(CGFloat )scale;
- (UIImage *_Nonnull)reSizeTo:(CGSize)reSize;
- (UIImage*_Nonnull)imageScaleToMaxSize:(CGSize )maxSize;

- (UIImage *_Nonnull)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *_Nonnull)imageRotatedByDegrees:(CGFloat)degrees;

+ (UIImage*_Nonnull)captureView:(UIView *_Nonnull)theView;
- (UIImage *_Nonnull)fixOrientationWithImageOrientation:(UIImageOrientation )orientation ;

+ (instancetype _Nonnull )imageWithColor:(nonnull UIColor *)color;

@end
