//
//  NSDate+Category.m
//  OneRed
//
//  Created by MBP on 14-7-22.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "NSDate+WGCategory.h"

@implementation NSDate (WGCategory)
+ (NSDateFormatter *)shareFormatter{
    static dispatch_once_t onceToken;
    static NSDateFormatter *formatter;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
    });
    return formatter;
}
- (NSString *)timeStringByFormatterString:( NSString *)formatterString{
    [[[self class]shareFormatter] setDateFormat:formatterString];
    return [[[self class]shareFormatter] stringFromDate:self];
}
+ (NSDate *)dateFromString:(NSString *)time WithFormatterString:(NSString *)formatterString{
    [[[self class]shareFormatter] setDateFormat:formatterString];
    NSDate *date = [[[self class] shareFormatter] dateFromString:time];
    return date;
}
+ (Second )secondFromString:(NSString *)time WithFormatterString:(NSString *)formatterString{
    NSDate *date = [self dateFromString:time WithFormatterString:formatterString];
    return [date timeIntervalSince1970];
}
+ (Millisecond )millisecondFromString:(NSString *)time WithFormatterString:(NSString *)formatterString{
    NSDate *date = [self dateFromString:time WithFormatterString:formatterString];
    return [date timeIntervalSince1970]*1000;
}
@end
