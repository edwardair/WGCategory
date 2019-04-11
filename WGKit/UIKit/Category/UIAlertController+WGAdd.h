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
+(instancetype)alert:(NSString *)title message:(NSString *)message ;
-(UIAlertController *)textField:(void(^)(UITextField *textField))configurationHandler;
-(UIAlertController *)secretTextField:(void(^)(UITextField *textField))configurationHandle;
-(void)show:(UIViewController *)from;
@end

#pragma mark - action
@interface UIAlertController (action)
-(UIAlertController *)cancelWithTitle:(NSString *)title;
-(UIAlertController *)cancelWithHandler:(void(^)(UIAlertAction *action))handler;
-(UIAlertController *)cancel:(NSString *)title handler:(void(^)(UIAlertAction *action))handler;
-(UIAlertController *)action:(NSString *)title handler:(void(^)(UIAlertAction *action))handler;

@end

#pragma mark - textField
@interface UIAlertController (textField)
@end
