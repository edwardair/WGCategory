//
//  UIAlertController+WGAdd.m
//  WGCategory
//
//  Created by RayMi on 2019/4/11.
//  Copyright © 2019 WG. All rights reserved.
//

#import "UIAlertController+WGAdd.h"

#pragma mark - initialize
@implementation UIAlertController (initialize)
+(instancetype)alert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    return alert;
}
+(instancetype)actionSheet:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    return alert;
}
-(UIAlertController *)textField:(void(^)(UITextField *textField))configurationHandler {
    [self addTextFieldWithConfigurationHandler:configurationHandler];
    return self;
}
-(UIAlertController *)secretTextField:(void(^)(UITextField *textField))configurationHandler {
    [self addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.secureTextEntry = YES;
        !configurationHandler?:configurationHandler(textField);
    }];
    return self;
}
-(void)show:(UIViewController *)from{
    [from presentViewController:self animated:YES completion:nil];
}
@end

#pragma mark - action
@implementation UIAlertController (action)
//MARK: - Cancel
-(UIAlertController *)cancelWithTitle:(NSString *)title {
    return [self cancel:title handler:nil];
}
-(UIAlertController *)cancelWithHandler:(void(^)(UIAlertAction *action))handler {
    return [self cancel:@"取消" handler:handler];
}
-(UIAlertController *)cancel:(NSString *)title handler:(void(^)(UIAlertAction *action))handler {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:handler];
    [self addAction:action];
    return self;
}
//MARK: - Action
-(UIAlertController *)action:(NSString *)title handler:(void(^)(UIAlertAction *action))handler {
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
    [self addAction:action];
    return self;
}
@end

#pragma mark - textField
@implementation UIAlertController (textField)
@end
