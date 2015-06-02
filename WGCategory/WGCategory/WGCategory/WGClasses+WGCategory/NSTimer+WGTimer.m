//
//  NSTimer+WGTimer.m
//  wuxigovapp
//
//  Created by Apple on 14-1-3.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "WGDefines.h"

@implementation NSTimer (WGTimer)
+ (NSTimer *)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo{
    
//    {
//        NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:YES];
//        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
//    }
    
    //与上面两句等效
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    //默认初始化后为停止计时状态 需要手动resume
    [timer pause];

    return timer;
}
- (void)pause{
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}
- (void)resume{
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}
- (void)stop{
    [self invalidate];
}
@end
