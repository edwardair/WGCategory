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
#import <objc/message.h>


@interface AA : NSObject
- (void)log1122;
@end

@implementation AA

- (void)log1122{
    NSLog(@"AAA");
}

@end


@interface Test : NSObject
- (void)log1122;
@end
@implementation Test

//- (void)log1122{
//    NSLog(@">>>>>>>>>>>>>%@",self);
//}
//BOOL a(){
//    _objc_msgForward;
//    return YES;
//}
void runtimeLog1122(Test *self, SEL _cmd){
    NSLog(@"BB");
}
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    BOOL a = [super resolveInstanceMethod:sel];
    if (!a) {
        if (sel==@selector(log1122)) {
            class_addMethod(self, @selector(log1122), (IMP)runtimeLog1122, "V@:");
        }
        return YES;
    }
    return a;
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector==@selector(log1122)) {
        return [[AA alloc]init];
    }
    return [super forwardingTargetForSelector:aSelector];
}
@end



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSObject *a = [[NSObject alloc]init];
    Test *b = [[Test alloc]init];
    
    if ([b respondsToSelector:@selector(log1122)]) {
        NSLog(@"yes");
    }else{
        NSLog(@"no");
    }
    if ([b respondsToSelector:@selector(log1122)]) {
        NSLog(@"yes");
    }else{
        NSLog(@"no");
    }

    
//    id c = [b forwardingTargetForSelector:@selector(log1122)];
    [b performSelector:@selector(log1122)];
    
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
