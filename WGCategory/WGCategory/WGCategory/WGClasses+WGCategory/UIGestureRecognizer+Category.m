//
//  WGGestureRecognizer.m
//  wuxigovapp
//
//  Created by Apple on 14-1-3.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@implementation UIGestureRecognizer(Category)
#ifdef InFrameTestMode

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView *touchView = touch.view;
    
    if ([touchView isKindOfClass:[WGFrameTest class]])
    {
        return YES;
    }
    else
    {
        return gestureRecognizer.enabled;
    }
}

#pragma clang diagnostic pop

#endif

#pragma mark - tag
static const char *property_tag;
- (int )tag{
    return [objc_getAssociatedObject(self, property_tag) intValue];
}
- (void)setTag:(int)tag{
    objc_setAssociatedObject(self, property_tag, @(tag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end

