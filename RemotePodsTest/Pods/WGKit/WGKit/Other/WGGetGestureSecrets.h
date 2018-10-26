//
//  Get4-9DifferentNumbers.h
//  9宫格手势键盘锁所有密码排列
//
//  Created by MBP on 14-7-2.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGGetGestureSecrets : NSObject
/**
 *  获取min-max长度所有手势密码的组合，9宫格密码，值的区间为1-9
 *
 *  @param min_ 最小长度
 *  @param max_ 最大长度
 *
 *  @return @[@[1开头所有密码],@[2开头所有密码], ... ]
 *
 *  @since v1.0
 */
+ (id )getGestureSecretsByMinLength:(int )min_ MaxLength:(int )max_;
@end
