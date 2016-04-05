//
//  WGCategory.m
//  WG通用模式
//
//  Created by Apple on 13-12-26.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "WGDefines.h"
#import <objc/runtime.h>


@implementation UIView(WGCategory)
#pragma mark - CGRect
CGPoint WGCGRectGetCenter(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect WGCGRectMoveTo(CGRect rect, CGPoint origin)
{
    CGPoint sub = CGPointMake(rect.origin.x-origin.x, rect.origin.y-origin.y);
    return WGCGRectMoveBy(rect, sub);
}

CGRect WGCGRectMoveBy(CGRect rect,CGPoint delta){
    rect.origin = CGPointMake(rect.origin.x+delta.x, rect.origin.y+delta.y);
    return rect;
}
CGRect WGCGRectScaleBy(CGRect rect,CGFloat scaleFactor){
    rect.size.width *= scaleFactor;
    rect.size.height *= scaleFactor;
    return rect;
}
CGRect WGCGRectChangeBy(CGRect rect, CGFloat dOriginX, CGFloat dOriginY, CGFloat dWidth, CGFloat dHeight){
    rect = WGCGRectMoveBy(rect, CGPointMake(dOriginX, dOriginY));
    rect.size.width += dWidth;
    rect.size.height += dHeight;
    return rect;
}
#pragma mark ----------------------------
#pragma mark	遍历查找self的父viewController
- (UIViewController *)superViewController{
    
    UIResponder *nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return (UIViewController*)nextResponder;
    }else{
        return self.superview.superViewController;
    }
}

#pragma mark ----------------------------
#pragma mark  重载系统方法，初始化默认背景色为clearColor
+ (instancetype)initWithNoneBGColor{
    id instance = [[[self class]alloc]init];
    [instance setBackgroundColor:[UIColor clearColor]];
    return instance;
}
+(instancetype)initWithNoneBGColorWithFrame:(CGRect)frame{
    id instance = [[[self class]alloc]initWithFrame:frame];
    [instance setBackgroundColor:[UIColor clearColor]];
    return instance;
}
#pragma mark ----------------------------
#pragma mark 获取view四周坐标及宽高

//origin
- (CGPoint )wg_leftOrigin{
    return self.frame.origin;
}
- (void)setWg_leftOrigin:(CGPoint)wg_leftOrigin{
    self.frame = WGCGRectMoveTo(self.frame, wg_leftOrigin);
}

//size
- (CGSize )wg_size{
    return self.frame.size;
}
- (void)setWg_size:(CGSize)wg_size{
    self.frame = WGCGRectChangeBy(self.frame, 0, 0, wg_size.width, wg_size.height);
}

//left
- (CGFloat)wg_left{
    return CGRectGetMinX(self.frame);
}
- (void)setWg_left:(CGFloat)wg_left{//设置left 相当于左右平移
    CGFloat delta = wg_left - self.wg_left;
    self.frame = WGCGRectMoveBy(self.frame, CGPointMake(delta, 0));
}

//right
- (CGFloat)wg_right{
    return CGRectGetMaxX(self.frame);
}
- (void)setWg_right:(CGFloat)wg_right{//设置right 同setWidth
    CGFloat delta = wg_right - self.wg_right;
    self.wg_width += delta;;
}

//top
- (CGFloat)wg_top{
    return CGRectGetMinY(self.frame);
}
- (void)setWg_top:(CGFloat)wg_top{//设置top相当于上下平移
    CGFloat delta = wg_top - self.wg_top;
    self.frame = WGCGRectMoveBy(self.frame, CGPointMake(0, delta));
}

//bottom
- (CGFloat)wg_bottom{
    return CGRectGetMaxY(self.frame);
}
- (void)setWg_bottom:(CGFloat)wg_bottom{//设置bottom相同setHeight
    CGFloat delta = wg_bottom - self.wg_bottom;
    self.wg_height += delta;
}

//width
- (CGFloat)wg_width{
    return CGRectGetWidth(self.frame);
}
- (void)setWg_width:(CGFloat)wg_width{
    CGFloat delta = wg_width- self.wg_width;
    self.frame = WGCGRectChangeBy(self.frame, 0, 0, delta, 0);
}

//hieght
- (CGFloat)wg_height{
    return CGRectGetHeight(self.frame);
}
- (void)setWg_height:(CGFloat)wg_height{
    CGFloat delta = wg_height- self.wg_height;
    self.frame = WGCGRectChangeBy(self.frame, 0, 0, 0, delta);
}


#pragma mark - copy zone
- (id )copyWithZone:(NSZone *)zone{
    UIView *newView = [[[self class]allocWithZone:zone] initWithFrame:self.frame];

    u_int count;
    objc_property_t *properties  = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i<count; i++){
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        [newView setValue:[self valueForKey:propertyName] forKey:propertyName];
    }
//
//    newView.backgroundColor = self.backgroundColor;
//    newView.tag = self.tag;
    for (UIView *sub in self.subviews) {
        [newView addSubview:[sub copy]];
    }
    return newView;
}


#pragma mark - 根据touches 获取坐标点
- (CGPoint )touchLocationWithTouches:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    return touchLocation;
}
- (CGPoint )preLocationWithTouches:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    CGPoint preLocation = [touch previousLocationInView:self];
    return preLocation;
}


#pragma mark - 设置圆角
- (void)setCorners:(UIRectCorner)corner ByRadius:(float)radius {
    UIBezierPath *maskPath =
    [UIBezierPath bezierPathWithRoundedRect:self.bounds
                          byRoundingCorners:corner
                                cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}




@end
