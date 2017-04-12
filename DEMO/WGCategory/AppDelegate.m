//
//  AppDelegate.m
//  WGCategory
//
//  Created by RayMi on 15/6/2.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import "AppDelegate.h"
#import "WGDefines.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSObject *a =[[NSObject alloc]init];
    [a wg_addBlock:(void *)(^(NSString *a, NSString *b, NSString *c){
        NSLog(@"a=%@",a);
        NSLog(@"b=%@",b);
        NSLog(@"c=%@",c);
        return a.intValue+b.intValue+c.intValue;
    })];

    int res = WGBLOCK(int, a)(@"1",@"2",@"3");
    NSLog(@"%d",res);

    WGBLOCK(void, a)(@"a1",@"b1",@"c1");
    NSLog(@"%@",WGBLOCK(NSString *, a)(@"a2",@"b2",@"c2"));
    
    ((void(^)())[a wg_doBlock])(@"a4",@"b4",@"c4");
    NSLog(@"%@",((NSString *(^)())[a wg_doBlock])(@"a5",@"b5",@"c5"));

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
