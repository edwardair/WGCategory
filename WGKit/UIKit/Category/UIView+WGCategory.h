//
//  WGCategory.h
//  WG通用模式
//
//  Created by Apple on 13-12-26.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

CGPoint WGCGRectGetCenter(CGRect rect);//获取rect的中心点
CGRect WGCGRectMoveTo(CGRect rect, CGPoint origin);//以左上角为基准点平移
CGRect WGCGRectMoveBy(CGRect rect, CGPoint delta);//以左上角为基准点平移
CGRect WGCGRectScaleBy(CGRect rect, CGFloat scaleFactor);//按照比例缩放到当前的scaleFactor倍数
CGRect WGCGRectChangeBy(CGRect rect, CGFloat dOriginX, CGFloat dOriginY, CGFloat dWidth, CGFloat dHeight);//按照给定参数不成比例修改rect

@interface UIView (WGCategory)
@property CGPoint wg_leftOrigin;
@property CGSize wg_size;
@property CGFloat wg_left;
@property CGFloat wg_right;
@property CGFloat wg_top;
@property CGFloat wg_bottom;
@property CGFloat wg_width;
@property CGFloat wg_height;

/**
 *  获取 UIView的父VC
 *
 *  @return VC
 */
- (UIViewController *)superViewController;

/**
 *  默认背景色为clearColor初始化 alloc init
 *
 *  @return UIView
 */
+ (instancetype )initWithNoneBGColor;

/**
 *  默认背景色为clearColor，带frame初始化，
 *
 *  @param frame
 *
 *  @return UIView
 */
+ (instancetype )initWithNoneBGColorWithFrame:(CGRect )frame;

/**
 *@brief UIView实现NSCopy协议
 *
 *@param 	zone 	NSZone
 *
 *@return	UIView复制对象
 */
- (id )copyWithZone:(NSZone *)zone;

/**
 *@brief	根据touches获取当前触摸坐标点
 *
 *@param 	touches 	NSSet
 *
 *@return	CGPoint
 */
- (CGPoint )touchLocationWithTouches:(NSSet *)touches;
/**
 *@brief	根据touches获取前一个触摸坐标点
 *
 *@param 	touches 	NSSet
 *
 *@return	CGPoint
 */
- (CGPoint )preLocationWithTouches:(NSSet *)touches;

/**
 *  设置圆角
 *
 *  @param corner 四角
 *  @param radius 半径
 */
- (void)setCorners:(UIRectCorner)corner ByRadius:(float)radius;

@end


