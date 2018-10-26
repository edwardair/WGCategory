//
//  FirstViewController.m
//  RemotePodsTest
//
//  Created by RayMi on 2018/9/29.
//  Copyright © 2018年 Roidmi. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSObject swizzleExchangeClassAPI:@selector(viewDidLoad) newSelector:@selector(myViewDidLoad)];
    [@"adf" stringFromRegularEpression:@"a*"];
}

- (void)myViewDidLoad{
    
}

@end

