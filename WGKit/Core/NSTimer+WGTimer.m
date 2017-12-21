//
//  NSTimer+WGTimer.m
//  wuxigovapp
//
//  Created by Apple on 14-1-3.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "WGDefines.h"

#pragma mark - NSTimer Target Helper

@implementation WGTimerTargetHelper
- (void)callSelector{
    if (_block) {
        _block(_timer,_userInfo);
    }
}
@end

#pragma mark -
@implementation NSTimer (WGTimer)
+ (instancetype)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeat{
    
//    {
//        NSTimer *timer = [NSTimer timerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:YES];
//        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
//    }
    
    //target会被NSTimer保留，故不需要再对target做强引用处理防止被释放
    WGTimerTargetHelper *target = [[WGTimerTargetHelper alloc]init];

    //与上面两句等效
    NSTimer *timer = [self scheduledTimerWithTimeInterval:ti target:target selector:@selector(callSelector) userInfo:userInfo repeats:repeat];
    //默认初始化后为停止计时状态 需要手动resume
    [timer pause];
    
    target.timer = timer;
    target.userInfo = userInfo;
    target.block = ^(NSTimer *timer_,id userInfo){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [aTarget performSelector:aSelector withObject:userInfo];
#pragma clang diagnostic pop
    };

    return timer;
}

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                            UserInfo:(id)userInfo
                            repeates:(BOOL)repeat
                               Block:(void (^)(NSTimer *, id))block{
    
    //target会被NSTimer保留，故不需要再对target做强引用处理防止被释放
    WGTimerTargetHelper *target = [[WGTimerTargetHelper alloc]init];
    
    NSTimer *timer = [self scheduledTimerWithTimeInterval:ti
                                                   target:target
                                                 selector:@selector(callSelector)
                                                 userInfo:userInfo
                                                  repeats:repeat];
    [timer pause];
    
    target.timer = timer;
    target.userInfo = userInfo;
    target.block = ^(NSTimer *timer_,id userInfo){
        if (block) {
            block(timer_,userInfo);
        }
    };
    
    return timer;
}

- (void)pause{
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}
- (void)resume{
    [self resumeTimerAfterTimeInterval:0];
}
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

- (void)stop{
    [self invalidate];
}
@end
