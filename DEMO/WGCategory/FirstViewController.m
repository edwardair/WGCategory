//
//  FirstViewController.m
//  WGCategory
//
//  Created by RayMi on 15/6/2.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "FirstViewController.h"
#import "WGDefines.h"

@interface A_B : NSObject
@property (nonatomic,strong) NSArray *array;
@end
@implementation A_B
@end

@interface AA : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) A_B *b;
@end
@implementation AA
@end



@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *dic = @{
                          @"name":@"A",
                          @"b":@{
                                  @"array":@[@"1",@"2",@"3"]
                                  }
                          };
    
    [AA autoGenerateModelPropertyWithData:dic];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
