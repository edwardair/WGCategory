//
//  WGButton+Category.m
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "UIButton+WGCategory.h"
#import "WGDefines.h"
@implementation UIButton (WGCategory)

@end




#pragma mark - UIButton修改为圆角按钮

@implementation RoundButton
- (void)setup{
    [self setCorners:UIRectCornerAllCorners ByRadius:5.f];
    self.clipsToBounds = YES;
}
- (id )initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}
- (id )initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (id)init{
    if ((self = [super init])) {
        [self setup];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}
@end
