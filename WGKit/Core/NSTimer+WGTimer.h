//
//  NSTimer+WGTimer.h
//  wuxigovapp
//
//  Created by Apple on 14-1-3.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark - NSTimer Target Helper

@interface WGTimerTargetHelper:NSObject
@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic,strong) id userInfo;
@property (nonatomic,copy) typeof(void(^)(NSTimer *timer_,id userInfo)) block;
- (void)callSelector;
@end

#pragma mark -
@interface NSTimer (WGTimer)
/**
 *  计时器初始化方法
 *
 *  @param ti        计时器间隔
 *  @param aTarget   receiver
 *  @param aSelector selector
 *  @param userInfo  userInfo
 *  @param repeat   是否重复
 *
 *  @return NSTimer instance Obj
 */
+ (instancetype)initWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeat;
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval )ti UserInfo:(id )userInfo repeates:(BOOL )repeat Block:(void(^)(NSTimer *timer_,id userInfo))block;


/**
*@brief	暂停计时器调用
*
*/
- (void)pause;

/**
*@brief	恢复计时器调用
*
*/
- (void)resume;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

/**
*@brief	停止计时器并移除，之后再次使用需要重新初始化
*
*/
- (void)stop;
@end
