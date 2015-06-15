//
//  FirstViewController.m
//  WGCategory
//
//  Created by RayMi on 15/6/2.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "FirstViewController.h"
#import "WGDefines.h"

@interface TEST_B_ARRAY_2_3:NSObject
@property (nonatomic,copy) NSString *ddd;
@end
@implementation TEST_B_ARRAY_2_3
@end
@interface TEST_B_ARRAY1_2:NSObject
@property (nonatomic,copy) NSString *ddd;
@end
@implementation TEST_B_ARRAY1_2
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
    
    TEST *model = [dic modelWithClass:[TEST class]];
    WGLogValue([model.b.array[0][0] ddd]);
    
    id dic1 = [model modelValue];
    
    WGLogFormatValue(@"%@：\n%@",NSStringFromClass([dic1 class]),dic1);
    
    id array2 = [model.b.array modelValue];
    WGLogFormatValue(@"%@：\n%@",NSStringFromClass([array2 class]),array2);
    
    WGLogWarn([self modelValue]);
    
    NSString *str = @"aa";
    WGLogWarn([str modelValue]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
