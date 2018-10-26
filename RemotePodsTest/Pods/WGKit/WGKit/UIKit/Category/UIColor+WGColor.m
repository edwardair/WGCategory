//
//  UIColor+WGColor.m
//  WeCommunity
//
//  Created by iOS ZYJ on 14-11-19.
//  Copyright (c) 2014年 Eduoduo. All rights reserved.
//

#import "UIColor+WGColor.h"

@implementation UIColor (WGColor)
- (CGFloat)color_r{
    return rgbaFromColor(self, R);
}
- (CGFloat)color_g{
    return rgbaFromColor(self, G);
}
- (CGFloat)color_b{
    return rgbaFromColor(self, B);
}
- (CGFloat)color_a{
    return rgbaFromColor(self, A);
}
@end
