//
//  WGLog.m
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "WGLog.h"
#import "NSString+WGString.h"

@implementation WGLog
#pragma mark - 打印处理
+ (void)logWithColor:(NSString *)color Value:(NSString *)value{
#if DEBUG
    NSString *head = @"";
    NSString *color_ = @"";
    NSString *foot = @"";
    if ([self isXcodeColorsEnable]) {
        head = XCODE_COLORS_ESCAPE;
        color_ = color;
        foot = XCODE_COLORS_RESET;
    }
    NSLog( (@"%@" @"%@" @"%@" @"%@"),head,color_,[NSString changeObjToString:value CurLV:0],foot);
#endif
}

#pragma mark - 检测 XcodeColors功能是否开启，未开启，使用原生NSLog，白色字体打印
+ (BOOL )isXcodeColorsEnable{
    char *xcode_colors = getenv(XCODE_COLORS);
    return (xcode_colors && (strcmp(xcode_colors, "YES") == 0));
}
#pragma mark - 开发测试界面 打印请求链接
+ (void)showRequestUrl:(NSString *)urlString
            Parameters:(NSDictionary *)parameters{
#if DEBUG
    {
        NSMutableString *string = [NSMutableString stringWithFormat:@"%@",urlString];
        
        [string appendString:@"?"];
        
        for (NSString *key in parameters.allKeys) {
            [string appendFormat:@"%@=%@&",key,parameters[key]];
        }
        
        if (!string) {
            WGLogError(@"jsonValue为空");
        }else{
            WGLogFormatMsg(@"请求链接:%@",string);
        }
    }
#endif
}
@end

