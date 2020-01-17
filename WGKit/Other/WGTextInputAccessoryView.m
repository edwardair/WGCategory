//
//  WGTextInputAccessoryView.m
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-28.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "WGTextInputAccessoryView.h"
#import "UIView+WGCategory.h"
#import "WGConstant.h"
#import "WGLog.h"
#import "NSObject+WGObject.h"

static WGTextInputAccessoryView *inputAccessoryView = nil;

@implementation WGTextInputAccessoryView

+ (id )shareInputAccessoryView{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inputAccessoryView = [WGTextInputAccessoryView initWithNoneBGColorWithFrame:CGRectMake(0, 0, Bounds.size.width, 50)];
        inputAccessoryView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:.5f];
    });
    
    return inputAccessoryView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _topInvalidHeight = 0;
//        _bottomInvalidHeight = 0;
        
        //添加键盘弹出监听
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
//        self.touchBegan = ^(NSSet *touches,UIEvent *event){
//            [self resignKeyBoard];
//        };
        
//        WGGestureRecognizer *tapGesture = [[WGGestureRecognizer alloc]initWithTarget:self action:@selector(taped)];
//        [self addGestureRecognizer:tapGesture];
//        tapGesture.delaysTouchesBegan = YES;
        
    }
    return self;
}

- (void)taped{
    WGLogMsg(@"空白区域手势点击取消键盘");
    
    [self resignKeyBoard];
}

#pragma mark - 显示、隐藏 self
- (void)showEmptyTouchViewWithHeight:(CGFloat )height_{
    UIWindow *keyWindow = KeyWindow;
    if (![self.superview isEqual:keyWindow]) {
        if (self.superview) [self removeFromSuperview];
        [keyWindow addSubview:self];
        
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taped)];
        [self addGestureRecognizer:tapGesture];
        tapGesture.delaysTouchesBegan = YES;

    }
    
    self.wg_top = _topInvalidHeight;
    self.wg_height = (height_-_topInvalidHeight);
//    self.height -= _bottomInvalidHeight;//设定height_之后，可能性的因为个别原因会再次修正下偏移，此版本默认为0
    
    self.hidden = NO;
}
- (void)hideEmptyTouchView{
    self.hidden = YES;
}

#pragma mark - 键盘弹出状态，self接收触摸处理方法
- (void)resignKeyBoard{
    [NSObject resignFirstResponder];
}

#pragma mark - NSNotificationCenter Receiver
- (void)keyboardWillShow:(NSNotification *)notification{
    WGLogMsg(@"keyboardWillShow");
    
    NSDictionary *userInfo = notification.userInfo;

    WGLogValue(userInfo);
    
    NSValue *frameEndUserInfoValue = userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    
    CGRect rect  =  [frameEndUserInfoValue CGRectValue];
    
    CGFloat height_ = rect.size.height;
    
    height_ = Bounds.size.height - height_;
    
    [self showEmptyTouchViewWithHeight:height_];
    
}
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    WGLogMsg(@"keyboardWillChangeFrame");
    NSDictionary *userInfo = notification.userInfo;
    
    WGLogValue(userInfo);
    
    
    NSValue *frameEndUserInfoValue = userInfo[@"UIKeyboardFrameEndUserInfoKey"];
    
    CGRect rect  =  [frameEndUserInfoValue CGRectValue];
    
    CGFloat height_ = rect.size.height;
    
    height_ = Bounds.size.height - height_;

    [self showEmptyTouchViewWithHeight:height_];
}
- (void)keyboardWillHide:(NSNotification *)notification{
    WGLogMsg(@"keyboardWillHide");
    
    [self hideEmptyTouchView];
    
}


@end
