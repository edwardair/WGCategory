//
//  NSDate+Category.h
//  OneRed
//
//  Created by MBP on 14-7-22.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSTimeInterval Second;//秒
typedef long long Millisecond;//毫秒

@interface NSDate (WGCategory)
+ (NSDateFormatter *)shareFormatter;
/**
 *  NSDate根据formatterString格式化出相应需要的年月日时分秒
 *
 *  @param formatterString 格式化字符串
 *
 *  @return 年月日时分秒
 */
- (NSString *)timeStringByFormatterString:(NSString*)formatterString;
/**
 *  将年月日按照格式化字符串转化为NSDate
 *
 *  @param time            年月日
 *  @param formatterString 格式化字符串
 *
 *  @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)time WithFormatterString:(NSString *)formatterString;
/**
 *  将年月日按照格式化字符串转化为秒
 *
 *  @param time            年月日
 *  @param formatterString 格式化字符串
 *
 *  @return 秒
 */
+ (Second)secondFromString:(NSString *)time WithFormatterString:(NSString *)formatterString;
/**
 *  将年月日按照格式化字符串转化为毫秒
 *
 *  @param time            年月日
 *  @param formatterString 格式化字符串
 *
 *  @return 毫秒
 */
+ (Millisecond)millisecondFromString:(NSString *)time WithFormatterString:(NSString*)formatterString;
@end
