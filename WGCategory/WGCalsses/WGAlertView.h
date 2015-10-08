//
//  WGAlertView.h
//  OneRed
//
//  Created by MBP on 14-8-4.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WGAlertView;
typedef void (^ AlertViewClickedAtIndex)(NSInteger buttonIndex,WGAlertView *alert_);

@protocol WGAlertViewDelegate <NSObject>

@optional
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)alertViewCancel:(UIAlertView *)alertView;
- (void)willPresentAlertView:(UIAlertView *)alertView;
- (void)didPresentAlertView:(UIAlertView *)alertView;
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView;
@end

@interface WGAlertView : UIAlertView<UIAlertViewDelegate>
@property (nonatomic,assign) id<WGAlertViewDelegate> wgDelegate;
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                        block:(AlertViewClickedAtIndex)block
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;
@end
