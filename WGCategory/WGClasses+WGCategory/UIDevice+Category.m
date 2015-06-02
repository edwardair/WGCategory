
#import "sys/sysctl.h"
#import "UIDevice+Category.h"

@implementation UIDevice (Category)

+ (UIDeviceResolution) currentResolution {
    static UIDeviceResolution dev = UIDevice_None;
    
    if (dev==UIDevice_None) {
        dev = [self getResolution];
    }
    return dev;
}

+ (UIDeviceResolution )getResolution{
#if TARGET_IPHONE_SIMULATOR
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            
            int h = MAX(result.width, result.height);//取 高度
            
            switch (h) {
                case 960:
                    return UIDevice_iPhoneHiRes;
                case 1136:
                    return UIDevice_iPhoneTallerHiRes;
                case 1334:
                    return UIDevice_iPhone6;
                case 2208:
                    return UIDevice_iPhone6P;
                case 2001:
                    return UIDevice_iPhone6P;
                default:
                    return UIDevice_iPhoneHiRes;
            }
        } else
            return UIDevice_iPhoneStandardRes;
    } else
        return (([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) ? UIDevice_iPadHiRes : UIDevice_iPadStandardRes);
#else
    size_t size;
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    WGLogFormatMsg(@"设备型号：%@",platform);
    
    if ([platform isEqualToString:@"iPhone1,1"])
        return UIDevice_iPhoneStandardRes;
    //      return @"iPhone 2G (A1203)";
    else if ([platform isEqualToString:@"iPhone1,2"])
        return UIDevice_iPhoneStandardRes;
    //      return @"iPhone 3G (A1241/A1324)";
    else if ([platform isEqualToString:@"iPhone2,1"])
        return UIDevice_iPhoneStandardRes;
    //      return @"iPhone 3GS (A1303/A1325)";
    else if ([platform isEqualToString:@"iPhone3,1"])
        return UIDevice_iPhoneHiRes;
    //      return @"iPhone 4 (A1332)";
    else if ([platform isEqualToString:@"iPhone3,2"])
        return UIDevice_iPhoneHiRes;
    //      return @"iPhone 4 (A1332)";
    else if ([platform isEqualToString:@"iPhone3,3"])
        return UIDevice_iPhoneHiRes;
    //      return @"iPhone 4 (A1349)";
    else if ([platform isEqualToString:@"iPhone4,1"])
        return UIDevice_iPhoneHiRes;
    //      return @"iPhone 4S (A1387/A1431)";
    else if ([platform isEqualToString:@"iPhone5,1"])
        return UIDevice_iPhoneTallerHiRes;
    //      return @"iPhone 5 (A1428)";
    else if ([platform isEqualToString:@"iPhone5,2"])
        return UIDevice_iPhoneTallerHiRes;
    //      return @"iPhone 5 (A1429/A1442)";
    else if ([platform isEqualToString:@"iPhone5,3"])
        return UIDevice_iPhoneTallerHiRes;
    //      return @"iPhone 5c (A1456/A1532)";
    else if ([platform isEqualToString:@"iPhone5,4"])
        return UIDevice_iPhoneTallerHiRes;
    //      return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    else if ([platform isEqualToString:@"iPhone6,1"])
        return UIDevice_iPhoneTallerHiRes;
    //      return @"iPhone 5s (A1453/A1533)";
    else if ([platform isEqualToString:@"iPhone6,2"])
        return UIDevice_iPhoneTallerHiRes;
    //      return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    else if ([platform isEqualToString:@"iPhone7,1"])
        return UIDevice_iPhone6P;
    //      return @"iPhone 6 Plus (A1522/A1524)";
    else if ([platform isEqualToString:@"iPhone7,2"])
        return UIDevice_iPhone6;
    //      return @"iPhone 6 (A1549/A1586)";
    
    else if ([platform isEqualToString:@"iPod1,1"])
        return UIDevice_iPhoneStandardRes;
    //      return @"iPod Touch 1G (A1213)";
    else if ([platform isEqualToString:@"iPod2,1"])
        return UIDevice_iPhoneStandardRes;
    //      return @"iPod Touch 2G (A1288)";
    else if ([platform isEqualToString:@"iPod3,1"])
        return UIDevice_iPhoneStandardRes;
    //      return @"iPod Touch 3G (A1318)";
    else if ([platform isEqualToString:@"iPod4,1"])
        return UIDevice_iPhoneHiRes;
    //      return @"iPod Touch 4G (A1367)";
    else if ([platform isEqualToString:@"iPod5,1"])
        return UIDevice_iPhoneTallerHiRes;
    //      return @"iPod Touch 5G (A1421/A1509)";
    
    else if ([platform isEqualToString:@"iPad1,1"])
        return UIDevice_iPadStandardRes;
    //      return @"iPad 1G (A1219/A1337)";
    
    else if ([platform isEqualToString:@"iPad2,1"])
        return UIDevice_iPadStandardRes;
    //      return @"iPad 2 (A1395)";
    else if ([platform isEqualToString:@"iPad2,2"])
        return UIDevice_iPadStandardRes;
    //      return @"iPad 2 (A1396)";
    else if ([platform isEqualToString:@"iPad2,3"])
        return UIDevice_iPadStandardRes;
    //      return @"iPad 2 (A1397)";
    else if ([platform isEqualToString:@"iPad2,4"])
        return UIDevice_iPadStandardRes;
    //      return @"iPad 2 (A1395+New Chip)";
    else if ([platform isEqualToString:@"iPad2,5"])
        return UIDevice_iPadStandardRes;
    //      return @"iPad Mini 1G (A1432)";
    else if ([platform isEqualToString:@"iPad2,6"])
        return UIDevice_iPadStandardRes;
    //      return @"iPad Mini 1G (A1454)";
    else if ([platform isEqualToString:@"iPad2,7"])
        return UIDevice_iPadStandardRes;
    //      return @"iPad Mini 1G (A1455)";
    
    else if ([platform isEqualToString:@"iPad3,1"])
        return UIDevice_iPadHiRes;
    //      return @"iPad 3 (A1416)";
    else if ([platform isEqualToString:@"iPad3,2"])
        return UIDevice_iPadHiRes;
    //      return @"iPad 3 (A1403)";
    else if ([platform isEqualToString:@"iPad3,3"])
        return UIDevice_iPadHiRes;
    //      return @"iPad 3 (A1430)";
    else if ([platform isEqualToString:@"iPad3,4"])
        return UIDevice_iPadHiRes;
    //      return @"iPad 4 (A1458)";
    else if ([platform isEqualToString:@"iPad3,5"])
        return UIDevice_iPadHiRes;
    //      return @"iPad 4 (A1459)";
    else if ([platform isEqualToString:@"iPad3,6"])
        return UIDevice_iPadHiRes;
    //      return @"iPad 4 (A1460)";
    
    else if ([platform isEqualToString:@"iPad4,1"])
        return UIDevice_iPadHiRes;
    //      return @"iPad Air (A1474)";
    else if ([platform isEqualToString:@"iPad4,2"])
        return UIDevice_iPadHiRes;
    //      return @"iPad Air (A1475)";
    else if ([platform isEqualToString:@"iPad4,3"])
        return UIDevice_iPadHiRes;
    //      return @"iPad Air (A1476)";
    else if ([platform isEqualToString:@"iPad4,4"])
        return UIDevice_iPadHiRes;
    //      return @"iPad Mini 2G (A1489)";
    else if ([platform isEqualToString:@"iPad4,5"])
        return UIDevice_iPadHiRes;
    //      return @"iPad Mini 2G (A1490)";
    else if ([platform isEqualToString:@"iPad4,6"])
        return UIDevice_iPadHiRes;
    //      return @"iPad Mini 2G (A1491)";
    
    else if ([platform isEqualToString:@"i386"])
        return UIDevice_Not_Supprot;
    //      return @"iPhone Simulator";
    else if ([platform isEqualToString:@"x86_64"])
        return UIDevice_Not_Supprot;
    //      return @"iPhone Simulator";
    
    WGLogError(@"此设备型号，当前封装不支持");
    return UIDevice_Not_Supprot;
    
#endif

}

+ (BOOL )isIOS7Version{
    return ([[UIDevice currentDevice]systemVersion].floatValue>=7.0);
}

@end
