//
//  WGLog.h
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-27.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef WGOBJC
#define WGOBJC(value) _WGOBCJ(@encode(__typeof__((value))), (value))
#endif

static inline id _WGOBCJ(const char *type, ...) {
  va_list v;
  va_start(v, type);
  id obj = nil;

  if (strcmp(type, @encode(id)) == 0) {
    obj = va_arg(v, id);
  } else if (strcmp(type, @encode(CGPoint)) == 0) {
    CGPoint actual = (CGPoint)va_arg(v, CGPoint);
    obj = [NSValue value:&actual withObjCType:type];
  } else if (strcmp(type, @encode(CGSize)) == 0) {
    CGSize actual = (CGSize)va_arg(v, CGSize);
    obj = [NSValue value:&actual withObjCType:type];
  } else if (strcmp(type, @encode(CGRect)) == 0) {
    CGRect actual = (CGRect)va_arg(v, CGRect);
    obj = [NSValue value:&actual withObjCType:type];
  } else if (strcmp(type, @encode(UIEdgeInsets)) == 0) {
    UIEdgeInsets actual = (UIEdgeInsets)va_arg(v, UIEdgeInsets);
    obj = [NSValue value:&actual withObjCType:type];
  } else if (strcmp(type, @encode(double)) == 0) {
    double actual = (double)va_arg(v, double);
    obj = [NSNumber numberWithDouble:actual];
  } else if (strcmp(type, @encode(float)) == 0) {
    float actual = (float)va_arg(v, double);
    obj = [NSNumber numberWithFloat:actual];
  } else if (strcmp(type, @encode(int)) == 0) {
    int actual = (int)va_arg(v, int);
    obj = [NSNumber numberWithInt:actual];
  } else if (strcmp(type, @encode(long)) == 0) {
    long actual = (long)va_arg(v, long);
    obj = [NSNumber numberWithLong:actual];
  } else if (strcmp(type, @encode(long long)) == 0) {
    long long actual = (long long)va_arg(v, long long);
    obj = [NSNumber numberWithLongLong:actual];
  } else if (strcmp(type, @encode(short)) == 0) {
    short actual = (short)va_arg(v, int);
    obj = [NSNumber numberWithShort:actual];
  } else if (strcmp(type, @encode(char)) == 0) {
    char actual = (char)va_arg(v, int);
    obj = [NSNumber numberWithChar:actual];
  } else if (strcmp(type, @encode(bool)) == 0) {
    bool actual = (bool)va_arg(v, int);
    obj = [NSNumber numberWithBool:actual];
  } else if (strcmp(type, @encode(unsigned char)) == 0) {
    unsigned char actual = (unsigned char)va_arg(v, unsigned int);
    obj = [NSNumber numberWithUnsignedChar:actual];
  } else if (strcmp(type, @encode(unsigned int)) == 0) {
    unsigned int actual = (unsigned int)va_arg(v, unsigned int);
    obj = [NSNumber numberWithUnsignedInt:actual];
  } else if (strcmp(type, @encode(unsigned long)) == 0) {
    unsigned long actual = (unsigned long)va_arg(v, unsigned long);
    obj = [NSNumber numberWithUnsignedLong:actual];
  } else if (strcmp(type, @encode(unsigned long long)) == 0) {
    unsigned long long actual =
        (unsigned long long)va_arg(v, unsigned long long);
    obj = [NSNumber numberWithUnsignedLongLong:actual];
  } else if (strcmp(type, @encode(unsigned short)) == 0) {
    unsigned short actual = (unsigned short)va_arg(v, unsigned int);
    obj = [NSNumber numberWithUnsignedShort:actual];
  }
  return obj;
}

/**
 *	@brief	NSString 封装格式初始化
 *
 *	@param 	 	format
 *
 *	@return	NSString
 */
#define WGFormatString(format, ...)                                            \
  [NSString stringWithFormat:format, ##__VA_ARGS__]

#pragma mark - XcodeColors
#define XCODE_COLORS "XcodeColors"

#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE_IOS                                                \
  @"\033[" //@"\xC2\xA0["
           //注：@"\xC2\xA0["为DEMO程序里面的原参数，但无效,改用MAC下的参数

#if TARGET_OS_IPHONE
#define XCODE_COLORS_ESCAPE XCODE_COLORS_ESCAPE_IOS
#else
#define XCODE_COLORS_ESCAPE XCODE_COLORS_ESCAPE_MAC
#endif

#define XCODE_COLORS_RESET_FG                                                  \
  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG                                                  \
  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET                                                     \
  XCODE_COLORS_ESCAPE @";" // Clear any foreground or background color

/**
 *  开启关闭XcodeColors
 *
 *  @param enable "YES" or "NO"
 *
 */
#define EnableXcodeColorsOrNot(enable)                                         \
  {                                                                            \
    setenv(XCODE_COLORS, enable ? "YES" : "NO", 0);                            \
  } //开启 或者关闭 XcodeColors

#pragma mark - colors
#define VALUE_COLOR @"fg0,184,229;"    //青色  value
#define MSG_COLOR @"fg255,119,177;"    //粉红色  msg
#define SEPARATE_COLOR @"fg126,1,255;" //紫色 参数名
#define ERROR_COLOR @"fg255,0,0;"      //红色  error
#define WARN_COLOR @"fg255,194,0;"     //黄色 warn
//#define QT_COLOR @"fg255,255,255;"//其他 白色

#pragma mark - 函数宏

//分割线
// const static NSString *separateLine = @"\n------------";
const static NSString *separateLine = @"";

/**
 *  包含 分隔符、方法名、行数
 */
#define LOG_TYPE_1(fmd, ...)                                                   \
  ([NSString                                                                   \
      stringWithFormat:                                                        \
          @"%@\n{ \n method: %s \n line:%d \n description:%@\n %@ \n}%@",      \
          separateLine, __PRETTY_FUNCTION__, __LINE__, separateLine,           \
          [NSString stringWithFormat:fmd, ##__VA_ARGS__], separateLine])

//仅仅 打印值
#define LOG_TYPE_2(fmd, ...)                                                   \
  ([NSString stringWithFormat:@"%@\n{\n %@ \n}%@", separateLine,               \
                              [NSString stringWithFormat:fmd, ##__VA_ARGS__],  \
                              separateLine])

#if DEBUG
//青色，打印：值
#define WGLogFormatValue(fmd, ...)                                             \
  [WGLog logWithColor:VALUE_COLOR                                              \
                Value:(LOG_TYPE_1(@">>>>>>>>>>>>>>>>>>>%@%@%s%@%@\n "          \
                                  @">>>>>>>>>>>>>>>>>>>" fmd,                 \
                                  XCODE_COLORS_ESCAPE, SEPARATE_COLOR,         \
                                  #__VA_ARGS__, XCODE_COLORS_ESCAPE,           \
                                  VALUE_COLOR, ##__VA_ARGS__))]
#define WGLogValue(...)                                                        \
  [WGLog                                                                       \
      logWithColor:VALUE_COLOR                                                 \
             Value:                                                            \
                 (LOG_TYPE_1(                                                  \
                     @">>>>>>>>>>>>>>>>>>>%@%@%s%@%@\n >>>>>>>>>>>>>>>>>>>%@", \
                     XCODE_COLORS_ESCAPE, SEPARATE_COLOR, #__VA_ARGS__,        \
                     XCODE_COLORS_ESCAPE, VALUE_COLOR, WGOBJC(__VA_ARGS__)))]

//粉色，打印：msg
#define WGLogFormatMsg(fmd, ...)                                               \
  [WGLog logWithColor:MSG_COLOR                                                \
                Value:(LOG_TYPE_2(@">>>>>>>>>>>>>>>>>>>%@%@%s%@%@\n "          \
                                  @">>>>>>>>>>>>>>>>>>>" fmd,                 \
                                  XCODE_COLORS_ESCAPE, SEPARATE_COLOR,         \
                                  #__VA_ARGS__, XCODE_COLORS_ESCAPE,           \
                                  MSG_COLOR, ##__VA_ARGS__))]
#define WGLogMsg(...)                                                          \
  [WGLog                                                                       \
      logWithColor:MSG_COLOR                                                   \
             Value:                                                            \
                 (LOG_TYPE_1(                                                  \
                     @">>>>>>>>>>>>>>>>>>>%@%@%s%@%@\n >>>>>>>>>>>>>>>>>>>%@", \
                     XCODE_COLORS_ESCAPE, SEPARATE_COLOR, #__VA_ARGS__,        \
                     XCODE_COLORS_ESCAPE, MSG_COLOR, WGOBJC(__VA_ARGS__)))]

//红色，打印：错误
#define WGLogFormatError(fmd, ...)                                             \
  [WGLog logWithColor:ERROR_COLOR                                              \
                Value:(LOG_TYPE_1(@">>>>>>>>>>>>>>>>>>>%@%@%s%@%@\n "          \
                                  @">>>>>>>>>>>>>>>>>>>" fmd,                  \
                                  XCODE_COLORS_ESCAPE, SEPARATE_COLOR,         \
                                  #__VA_ARGS__, XCODE_COLORS_ESCAPE,           \
                                  ERROR_COLOR, ##__VA_ARGS__))]
#define WGLogError(...)                                                        \
  [WGLog                                                                       \
      logWithColor:ERROR_COLOR                                                 \
             Value:                                                            \
                 (LOG_TYPE_1(                                                  \
                     @">>>>>>>>>>>>>>>>>>>%@%@%s%@%@\n >>>>>>>>>>>>>>>>>>>%@", \
                     XCODE_COLORS_ESCAPE, SEPARATE_COLOR, #__VA_ARGS__,        \
                     XCODE_COLORS_ESCAPE, ERROR_COLOR, WGOBJC(__VA_ARGS__)))]

//橘黄色，打印：警告
#define WGLogFormatWarn(fmd, ...)                                              \
  [WGLog logWithColor:WARN_COLOR                                               \
                Value:(LOG_TYPE_1(@">>>>>>>>>>>>>>>>>>>%@%@%s%@%@\n "          \
                                  @">>>>>>>>>>>>>>>>>>>" fmd,                 \
                                  XCODE_COLORS_ESCAPE, SEPARATE_COLOR,         \
                                  #__VA_ARGS__, XCODE_COLORS_ESCAPE,           \
                                  WARN_COLOR, ##__VA_ARGS__))]
#define WGLogWarn(...)                                                         \
  [WGLog                                                                       \
      logWithColor:WARN_COLOR                                                  \
             Value:                                                            \
                 (LOG_TYPE_1(                                                  \
                     @">>>>>>>>>>>>>>>>>>>%@%@%s%@%@\n >>>>>>>>>>>>>>>>>>>%@", \
                     XCODE_COLORS_ESCAPE, SEPARATE_COLOR, #__VA_ARGS__,        \
                     XCODE_COLORS_ESCAPE, WARN_COLOR, WGOBJC(__VA_ARGS__)))]

#else
#define WGLogFormatValue(fmd, ...)
#define WGLogValue(...)
#define WGLogFormatMsg(fmd, ...)
#define WGLogMsg(...)
#define WGLogFormatError(fmd, ...)
#define WGLogError(...)
#define WGLogFormatWarn(fmd, ...)
#define WGLogWarn(...)
#endif
/**
 *@brief	NSLog封装，带颜色、方法名、方法、line打印
 */
@interface WGLog : NSObject
+ (void)logWithColor:(NSString *)color Value:(NSString *)value;
#pragma mark - 开发测试界面 打印请求链接
+ (void)showRequestUrl:(NSString *)urlString
            Parameters:(NSDictionary *)parameters;
@end
