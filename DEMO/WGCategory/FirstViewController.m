//
//  FirstViewController.m
//  WGCategory
//
//  Created by RayMi on 15/6/2.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "FirstViewController.h"
#import "WGDefines.h"

@interface TEST_B_ARRAY_0_1:NSObject
@property (nonatomic,copy) NSString *ddd;
@end
@implementation TEST_B_ARRAY_0_1
@end
@interface TEST_B_ARRAY1_0:NSObject
@property (nonatomic,copy) NSString *ddd;
@end
@implementation TEST_B_ARRAY1_0
@end
@interface TEST_B_DIC:NSObject
@property (nonatomic,copy) NSString *ccc;
@end
@implementation TEST_B_DIC
@end
@interface TEST_B:NSObject
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSArray *array1;
@property (nonatomic,strong) TEST_B_DIC *dic;
@end
@implementation TEST_B
@end
@interface TEST:NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) TEST_B *b;
@end
@implementation TEST
@end


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *dic = @{
                          @"name" : @"A",
                          @"b" : @{
                                  @"array" :@[
                                          @[
                                              @{@"ddd" : @"ddddd"
                                                }
                                              ]
                                          ],
                                  @"array1" : @[
                                          @{@"ddd" : @"ddddd"}
                                          ],
                                  @"dic" : @{@"ccc" : @"aaaa"}
                                  }
                          };
    
    [dic logWithKey:@"TEST"];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
