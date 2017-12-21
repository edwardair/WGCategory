

#import <UIKit/UIKit.h>

#define isSysVersionAvailable(v) ({BOOL y_=NO;if(@available(iOS v, *)) y_=YES;y_;})

typedef NS_ENUM(int, UIDeviceResolution){
    UIDevice_None                   = -1,   //                                     未检测
    UIDevice_iPhoneStandardRes      = 1,    // iPhone 1,3,3GS Standard Resolution   (320x480px)
    UIDevice_iPhoneHiRes,                   // iPhone 4,4S High Resolution          (640x960px)
    UIDevice_iPhoneTallerHiRes,             // iPhone 5 High Resolution             (640x1136px)
    UIDevice_iPadStandardRes,               // iPad 1,2,mini1 Standard Resolution   (1024x768px)
    UIDevice_iPadHiRes,                     // iPad 3...,mini2... High Resolution   (2048x1536px)
    UIDevice_iPadPro_10_5,                  //iPad Pro 10.5 Inch                    (2224 x 1668px)
    UIDevice_iPadPro_12_9,                  //iPad Pro 12.9 Inch                    (2732 x 2048px)
    
    UIDevice_iPhone6,                       // iPhone6 High Resolution              (1334x750px)
    UIDevice_iPhone6P,                      // iPhone6P High Resolution             (2208*1242px)
    UIDevice_iPhoneX,                       // iPhoneX High Resolution               (1125*2436px)
    UIDevice_Not_Supprot            = 999,  //                                    不支持
};

@interface UIDevice (WGCategory)
/**
 *@brief	获取当前设备分辨率模式，区分iPhone高低请、iPad高低请、iPhone 3.5inch、iPhone 4.0inch
 *
 *@return	UIDeviceResolution
 */
+ (UIDeviceResolution) currentResolution;
/**
 *@brief	当前设备系统版本，区分iOS7  or 以下，YES：iOS7，NO：iOS7以下版本
 *
 *@return	BOOL
 */
+ (BOOL)isIOS7Version;
@end
