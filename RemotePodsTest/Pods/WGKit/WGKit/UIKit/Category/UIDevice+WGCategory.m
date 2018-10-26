
#import "sys/sysctl.h"
#import "UIDevice+WGCategory.h"

@implementation UIDevice (WGCategory)
+ (UIDeviceResolution) currentResolution {
    static UIDeviceResolution dev = UIDevice_None;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dev = [self getResolution];
    });
    return dev;
}
+ (UIDeviceResolution )getResolutionWith:(NSInteger )height{
    switch (height) {
        //iPad
        case 1024:
            return UIDevice_iPadStandardRes;
        case 2048:
            return UIDevice_iPadHiRes;
        case 2224:
            return UIDevice_iPadPro_10_5;
        case 2732:
            return UIDevice_iPadPro_12_9;

        //iPhone
        case 480:
            return UIDevice_iPhoneStandardRes;
        case 960:
            return UIDevice_iPhoneHiRes;
        case 1136:
            return UIDevice_iPhoneTallerHiRes;
        case 1334:
            return UIDevice_iPhone6;
        case 2208:
        case 2001:
            return UIDevice_iPhone6P;
        case 2436:
            return UIDevice_iPhoneX;
        default:
            return UIDevice_Not_Supprot;
    }
}
+ (NSInteger)getScreenHeight{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
        result = CGSizeMake(result.width * [UIScreen mainScreen].scale,
                            result.height * [UIScreen mainScreen].scale);
    }
    NSInteger h = MAX(result.width, result.height);//取 高度
    return h;
}
+ (UIDeviceResolution )getResolution{
    NSInteger height = [self getScreenHeight];
    UIDeviceResolution i = [self getResolutionWith:height];
    //MARK: 由于iPhone与iPad高度不存在相同情况，故无需判断设备型号
//    UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
    return i;
}

+ (BOOL )isIOS7Version{
    return isSysVersionAvailable(7.0);
}
@end
