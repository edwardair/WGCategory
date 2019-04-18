//
//  WGAlertView.m
//  OneRed
//
//  Created by MBP on 14-8-4.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "WGAlertView.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80300

@interface WGAlertView ()
@end
@implementation WGAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                        block:(AlertViewClickedAtIndex)block
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...{
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:nil
              otherButtonTitles:otherButtonTitles,nil];
    if (self) {
        _block = block;
        
        va_list argList;
        NSString *otherButtonTitle;
        va_start(argList, otherButtonTitles);
        while ( (otherButtonTitle=va_arg(argList, NSString *)) ) {
            [self addButtonWithTitle:otherButtonTitle];
        }
        //最后添加cancelButtonTitle
        if (cancelButtonTitle) {
            [self addButtonWithTitle:cancelButtonTitle];
        }
    }
    return self;
}
#pragma mark - setter
- (void)setBlock:(AlertViewClickedAtIndex)block{
    _block = block;
    
    self.delegate = self;
    
}

#pragma mark - UIAlertView delegate -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.wgDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.wgDelegate alertView:alertView clickedButtonAtIndex:buttonIndex];
    }
    else if (_block) {
        _block(buttonIndex,self);
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView{
    if ([self.wgDelegate respondsToSelector:@selector(alertViewCancel:)])
        [self.wgDelegate alertViewCancel:alertView];
}
- (void)willPresentAlertView:(UIAlertView *)alertView{
    if ([self.wgDelegate respondsToSelector:@selector(willPresentAlertView:)])
        [self.wgDelegate willPresentAlertView:alertView];
}
- (void)didPresentAlertView:(UIAlertView *)alertView{
    if ([self.wgDelegate respondsToSelector:@selector(didPresentAlertView:)])
        [self.wgDelegate didPresentAlertView:alertView];
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ([self.wgDelegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)])
        [self.wgDelegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ([self.wgDelegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)])
        [self.wgDelegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
}
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    if ([self.wgDelegate respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)])
        return [self.wgDelegate alertViewShouldEnableFirstOtherButton:alertView];
    else
        return YES;
}

@end

#endif
