//
//  TestTimerVCViewController.m
//  WGCategory
//
//  Created by RayMi on 15/7/15.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "TestTimerVCViewController.h"
#import "WGDefines.h"
@interface TestTimerVCViewController ()
@property (nonatomic,weak) NSTimer *timer;
@end

@implementation TestTimerVCViewController
- (void)dealloc{
    NSLog(@"deallocka111111111");
    
    [_timer invalidate];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 UserInfo:nil repeates:YES Block:^(NSTimer *timer_,id userInfo){
        NSLog(@"%@",[NSDate date]);
    }];
    
    [timer resume];
    
    _timer = timer;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:NULL];
    });
}




@end
