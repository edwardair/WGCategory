//  WGCategory+NSObject.m
//  WGCategoryAppend
//
//  Created by Apple on 13-12-30.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "NSObject+WGObject.h"
#import "WGConstant.h"
#import "NSString+WGString.h"
#import "WGLog.h"

@implementation NSObject(WGObject)
#pragma mark - 纯提示性UIAlertView显示
+ (void)alertShowErrorWithMsg:(NSString *)msg{
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 90000
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@""
                                                   message:msg
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles: nil];
    [alert show];
#else
    [[[UIAlertController alert:@"" message:msg] cancel:@"OK" handler:nil] show:KeyWindow.rootViewController];
#endif
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
+ (void)swizzleExchangeInstanceAPI:(SEL )oldSelector newSelector:(SEL )newSelector{
    Method oldMethod = class_getInstanceMethod(self, oldSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    method_exchangeImplementations(oldMethod,newMethod);
}
+ (void)swizzleExchangeClassAPI:(SEL )oldSelector newSelector:(SEL )newSelector{
    Method oldMethod = class_getClassMethod(self, oldSelector);
    Method newMethod = class_getClassMethod(self, newSelector);
    method_exchangeImplementations(oldMethod,newMethod);
}
+ (BOOL)swizzleAddInstanceAPI:(SEL )newSelector withIMP:(IMP)imp types:(const char *)types{
    Method newMethod = class_getInstanceMethod(self, newSelector);
    if (!newMethod) {
        return class_addMethod(self, newSelector, imp, types);
    }
    return NO;
}
+ (BOOL)swizzleAddClassAPI:(SEL )newSelector withIMP:(IMP)imp types:(const char *)types{
    Method newMethod = class_getClassMethod(self, newSelector);
    if (!newMethod) {
        return class_addMethod(self, newSelector, imp, types);
    }
    return NO;
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
    
#pragma mark - 获取属性名对应的Class
+ (PropertyClass)propertyClass{
    PropertyClass block = ^ Class (NSString *propertyName){
        return [self getPropertyClass:propertyName];
    };
    return block;
}
+ ( Class )getPropertyClass:(NSString *)propertyName{
    objc_property_t property = class_getProperty(self, propertyName.UTF8String);
    char *columnPropertyAttributes = property_copyAttributeValue(property, "T");
    NSString *className = [NSString stringWithFormat:@"%s",columnPropertyAttributes];
    free(columnPropertyAttributes);
    className = [className stringFromRegularEpression:@"[^@\"]+"].firstObject;
    return NSClassFromString(className);
}
+ (PropertyClass)propertyClass_NSArray{
    PropertyClass block = ^ Class(NSString *propertyName){
        return  [self getPropertyClass_NSArray:propertyName];
    };
    return block;
}
+ ( Class  )getPropertyClass_NSArray:(NSString *)propertyName{
    objc_property_t property = class_getProperty(self, propertyName.UTF8String);
    char *columnPropertyAttributes = property_copyAttributeValue(property, "T");
    NSString *className = [NSString stringWithFormat:@"%s",columnPropertyAttributes];
    free(columnPropertyAttributes);
    className = [className stringFromRegularEpression:@"[^<]*(?=>)"].firstObject;
    return NSClassFromString(className);
}
@end
