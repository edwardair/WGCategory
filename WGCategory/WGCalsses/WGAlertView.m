//
//  WGAlertView.m
//  OneRed
//
//  Created by MBP on 14-8-4.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "WGAlertView.h"

@interface WGAlertView ()
@property (nonatomic,copy) AlertViewClickedAtIndex block;
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

#pragma mark - UIAlertView delegate -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (_block) {
        _block(buttonIndex,self);
    }
}

@end
