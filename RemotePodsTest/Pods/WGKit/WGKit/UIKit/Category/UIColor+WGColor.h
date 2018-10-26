//
//  UIColor+WGColor.h
//  WeCommunity
//
//  Created by iOS ZYJ on 14-11-19.
//  Copyright (c) 2014年 Eduoduo. All rights reserved.
//

#import <UIKit/UIKit.h>

//----------------------------------
//16进制字符串 @"ffffffff"转化为UIColor，支持 fffffffff或者#ffffffff格式
static inline  UIColor * colorWithHexString(NSString *str){
    if (!str || [str isEqualToString:@""]) {
        return [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    }
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    }
    
    unsigned rgba[4] = {255,255,255,255};// 默认 alpha==1
    int hexLen = 2;//一个十六进制字符长度，代表一个r、g、b、a
    NSRange range;
    int index = 0;
    for (int i = 0; i < str.length; i+=hexLen) {
        if (i<=(str.length-hexLen)) {
            range = NSMakeRange(i, hexLen);
            [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&rgba[index++]];
        }
    }

    UIColor *color= [UIColor colorWithRed:rgba[0]/255.0f green:rgba[1]/255.0f blue:rgba[2]/255.0f alpha:rgba[3]/255.f];
    return color;
}

//----------------------------------
//255,255,255,255 转化为UIColor
static inline UIColor * colorWithRGB(float r,float g,float b){
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:255/255.f];
}
static inline UIColor * colorWithRGBA(float r,float g,float b,float a){
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.f];
}


//----------------------------------
//从UIColor中提取 r/g/b/a 四色值，无值的默认为1.f
//MARK: 可能不能提取 系统颜色 ，如：[UIColor whiteColor]
//MARK: 已测试：[UIColor colorWithPatternImage:<#(UIImage *)#>]无法提取
typedef NS_ENUM(int, RGBA) {
    R = 0,
    G,
    B,
    A
};
static inline CGFloat rgbaFromColor(UIColor *color,RGBA index){
    CGFloat x = 1.f;//默认值、最大值为1
    CGColorRef ref = color.CGColor;
    int numComponents = (int)CGColorGetNumberOfComponents(ref);
    if (numComponents >index){
        const CGFloat *components = CGColorGetComponents(ref);
        x = components[index];
    }
    return x;
}


@interface UIColor (WGColor)
@property (nonatomic,assign,readonly) CGFloat color_r;
@property (nonatomic,assign,readonly) CGFloat color_g;
@property (nonatomic,assign,readonly) CGFloat color_b;
@property (nonatomic,assign,readonly) CGFloat color_a;
@end
