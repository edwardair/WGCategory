//
//  WGTextView.m
//  FengYeZhiXiang
//
//  Created by iOS ZYJ on 14-9-3.
//  Copyright (c) 2014年 ___E多多___. All rights reserved.
//

#import "WGTextView.h"

@implementation WGTextView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize{
    _placeHolderOrigin = CGPointMake(8, 8);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidBeginEditingNotification object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)setPlaceHolderOrigin:(CGPoint)placeHolderOrigin {
    _placeHolderOrigin = placeHolderOrigin;
    [self setNeedsDisplay];
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    [self setNeedsDisplay];
}

- (void)textDidChanged:(NSNotification *)noti{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    if (self.text.length == 0) {
        //绘制placeHolder
        if (_placeHolder.length) {
            [_placeHolder
             drawInRect:CGRectMake(
                                   _placeHolderOrigin.x,
                                   _placeHolderOrigin.y,
                                   rect.size.width - _placeHolderOrigin.x * 2,
                                   rect.size.height - _placeHolderOrigin.y * 2
                                   )
             withAttributes:@{
                              NSFontAttributeName : self.font,
                              NSForegroundColorAttributeName : [UIColor lightGrayColor],
                              NSParagraphStyleAttributeName :
                                  [NSParagraphStyle defaultParagraphStyle]
                              }];
        }else if (_attributedString) {
            [_attributedString
             drawInRect:CGRectMake(
                                   _placeHolderOrigin.x,
                                   _placeHolderOrigin.y,
                                   rect.size.width - _placeHolderOrigin.x * 2,
                                   rect.size.height - _placeHolderOrigin.y * 2
                                   )];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];

}

@end
