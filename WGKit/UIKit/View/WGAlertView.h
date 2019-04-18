//
//  WGAlertView.h
//  OneRed
//
//  Created by MBP on 14-8-4.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80300

@class WGAlertView;
typedef void (^ AlertViewClickedAtIndex)(NSInteger buttonIndex,WGAlertView *alert_);

#define ShowAlert(title, msg, cancelTitle, ...)                                \
  ({                                                                           \
    WGAlertView *alert_ = [[WGAlertView alloc] initWithTitle:title             \
                                                     message:msg               \
                                                    delegate:nil               \
                                           cancelButtonTitle:cancelTitle       \
                                           otherButtonTitles:__VA_ARGS__];     \
    alert_;                                                                    \
  })

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
@property (nonatomic,copy) AlertViewClickedAtIndex block;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                        block:(AlertViewClickedAtIndex)block
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;
@end

#endif
