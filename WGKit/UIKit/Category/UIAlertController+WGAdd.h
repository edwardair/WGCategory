//
//  UIAlertController+WGAdd.h
//  WGCategory
//
//  Created by RayMi on 2019/4/11.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - initialize
@interface UIAlertController (initialize)
+(_Nonnull instancetype)alert:(NSString * _Nullable)title message:(NSString * _Nullable)message;
+(_Nonnull instancetype)actionSheet:(NSString * _Nullable)title message:(NSString * _Nullable)message;
-(UIAlertController * _Nonnull)textField:(void(^)(UITextField * _Nonnull textField))configurationHandler;
-(UIAlertController * _Nonnull)secretTextField:(void(^)(UITextField * _Nonnull textField))configurationHandle;
-(void)show:(UIViewController *_Nonnull)from;
@end

#pragma mark - action
@interface UIAlertController (action)
-(UIAlertController * _Nonnull)cancelWithTitle:(NSString * _Nullable)title;
-(UIAlertController * _Nonnull)cancelWithHandler:(void(^)(UIAlertAction * _Nullable action))handler;
-(UIAlertController * _Nonnull)cancel:(NSString * _Nullable)title handler:(void(^)(UIAlertAction * _Nonnull action))handler;
-(UIAlertController * _Nonnull)action:(NSString * _Nullable)title handler:(void(^)(UIAlertAction * _Nonnull action))handler;

@end

#pragma mark - textField
@interface UIAlertController (textField)
@end
