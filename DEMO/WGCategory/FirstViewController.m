//
//  FirstViewController.m
//  WGCategory
//
//  Created by RayMi on 15/6/2.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "FirstViewController.h"
#import "WGDefines.h"
#import "TestTimerVCViewController.h"

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


@interface TEST2:NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSValue *b;
@end
@implementation TEST2
@end


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    endtime = "2015-10-27 19:58:46";
//    isok = 1;
//    objectId = R6seM88I;
//    openid = c72f0ce72ce6e3cd;
//    regtime = "2015-09-27 19:57:46";

    NSString *reg = @"2015-09-27 19:57:46";
    NSString *end = @"2015-10-27 19:58:46";
    NSDate *regDate = [NSDate dateFromString:reg WithFormatterString:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [NSDate dateFromString:end WithFormatterString:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *now = [NSDate date];
    NSTimeInterval a = [now timeIntervalSinceDate:regDate];
    NSTimeInterval b = [now timeIntervalSinceDate:endDate];

    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:[[TestTimerVCViewController alloc]init] animated:YES completion:NULL];

    });
    
    id str111 = [[NSClassFromString(@"NSValue") alloc]init];
    if (!str111) {
        WGLogValue(@"aaaaa");
    }
    
    id dic = @{
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
    
    //MODEL转字典
    TEST2 *test2 = [[TEST2 alloc]init];
    test2.name = @"test2";
    test2.b = nil;//检测test2在转字典时，能否将b对应的key加入到字典中
    WGLogValue(test2.modelValue);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
