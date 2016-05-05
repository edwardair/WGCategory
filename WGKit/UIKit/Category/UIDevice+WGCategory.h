

#import <UIKit/UIKit.h>

enum {
    UIDevice_None                   = -1,//                                    未检测
    UIDevice_iPhoneStandardRes      = 1,// iPhone 1,3,3GS Standard Resolution   (320x480px)
    UIDevice_iPhoneHiRes            = 2,// iPhone 4,4S High Resolution          (640x960px)
    UIDevice_iPhoneTallerHiRes      = 3,// iPhone 5 High Resolution             (640x1136px)
    UIDevice_iPadStandardRes        = 4,// iPad 1,2,mini1 Standard Resolution   (1024x768px)
    UIDevice_iPadHiRes              = 5,// iPad 3...,mini2... High Resolution   (2048x1536px)
    UIDevice_iPhone6                = 6,// iPhone6 High Resolution              (1334x750px)
    UIDevice_iPhone6P               = 7,// iPhone6P High Resolution             (2208*1242px)
    UIDevice_Not_Supprot            = 999,//                                    不支持
}; typedef NSUInteger UIDeviceResolution;


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
