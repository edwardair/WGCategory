//
//  WGCategory+NSObject.m
//  WGCategoryAppend
//
//  Created by Apple on 13-12-30.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "WGDefines.h"
#import <objc/runtime.h>

@implementation NSObject(WGObject)
#pragma mark - 纯提示性UIAlertView显示
+ (void)alertShowErrorWithMsg:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                   message:msg
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles: nil];
    [alert show];
}

#pragma mark - 根据绝对路径 计算单个文件大小
+ (long)mathFileSize:(NSString *)path{
    long size = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:path error:nil];
    if (fileAttributeDic) {
        size += fileAttributeDic.fileSize;
    }
    return size;
}
#pragma mark - 计算绝对路径文件夹下文件的总大小
+ (long)mathDirSize:(NSString *)path{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    long size = 0;
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            size += [self mathFileSize:fullPath];
        }
        else
        {
            [self mathFileSize:fullPath];
        }
    }
    return size;
}

#pragma mark - 注销第一响应者
+ (void)resignFirstResponder{
    UIWindow *keyWindow = KeyWindow;
    UIView *firstResponder = [keyWindow valueForKeyPath:@"_firstResponder"];
    if (firstResponder) {
        [firstResponder resignFirstResponder];
    }
}

#pragma mark - category 修改系统api
+ (void)replaceSystemAPI:(SEL )originSelector ByReplacedSelector:(SEL )replaceSelector{
    
    Class aClass = [self class];
    Method originMethod = class_getInstanceMethod(aClass, originSelector);
    Method replaceMethod = class_getInstanceMethod(aClass, replaceSelector);
    
    //    // 将目标函数的原实现绑定到original Implemention方法上
    //    IMP originIMP = method_getImplementation(originMethod);
    //    class_addMethod(aClass, originSelector, originIMP, method_getTypeEncoding(originMethod));
    
    // 然后用我们自己的函数的实现，替换目标函数对应的实现
    IMP replaceIMP = method_getImplementation(replaceMethod);
    class_replaceMethod(aClass, originSelector, replaceIMP, method_getTypeEncoding(originMethod));
    
}


#pragma mark - 获取系统语言
+ (NSString *)systemLanguage{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //系统支持的所有语言
    NSArray *languages = [userDefault objectForKey:@"AppleLanguages"];
    
    return [languages objectAtIndex:0];
}

#pragma mark - 覆写NSObject的nilValue方法，防止程序闪退
- (void)setNilValueForKey:(NSString *)key{
    WGLogFormatWarn(@"%@企图设置nilValue，key=%@",NSStringFromClass([self class]),key);
}
                    
@end
