//
//  WGAlertView.h
//  OneRed
//
//  Created by MBP on 14-8-4.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ AlertViewClickedAtIndex)(NSInteger buttonIndex);

@interface WGAlertView : UIAlertView<UIAlertViewDelegate>
- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                        block:(AlertViewClickedAtIndex)block
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;
@end
