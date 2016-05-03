//
//  AppDelegate.m
//  WGCategory
//
//  Created by RayMi on 15/6/2.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "AppDelegate.h"
#import "WGDefines.h"
#import <objc/runtime.h>


@interface ATest_List_V1_V2:NSObject
@property (nonatomic,copy) NSString *v3;
@end
@implementation ATest_List_V1_V2
@end
@interface ATest_List_V1Test:NSObject
@property (nonatomic,strong) ATest_List_V1_V2 *v2;
@end
@implementation ATest_List_V1Test
@end
@interface ATest_List:NSObject
@property (nonatomic,strong) ATest_List_V1Test *v1;
@end
@implementation ATest_List
@end

@protocol ATest_List;
@interface ATest:NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSNumber *value;
@property (nonatomic,strong) NSArray<ATest_List> *list;
@end
@implementation ATest
@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSArray *a1 = @[];
    NSArray *a2 = [NSArray arrayWithArray:a1];
    NSMutableArray *a3 = [[NSMutableArray alloc]init];
    
    
    NSDictionary *dic = @{
                          @"name":@"test",
                          @"value":@5,
                          @"list":@[
                                  @{@"v1":@{@"v2":@{@"v3":@"test1"}}},
                                  @{@"v1":@{@"v2":@{@"v3":@"test2"}}},
                                  @{@"v1":@{@"v2":@{@"v3":@"test3"}}},
                                  ],
//                          @"list1":@[
//                                  @{@"v1":@{@"v1":@[@1,@2,@3]}},
//                                  @{@"v2":@{@"v1":@[@1,@2,@3]}},
//                                  @{@"v3":@{@"v1":@[@1,@2,@3]}},
//                                  ],
                          };
    [dic logWithKey:@"ATest"];

    ATest *testModel = [dic modelWithClass:[ATest class]];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
