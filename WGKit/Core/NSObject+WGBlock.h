//
//  NSObject+WGBlock.h
//  WGCategory
//
//  Created by RayMi on 17/4/11.
//  Copyright © 2017年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef WGBLOCK
/**
 *  do block
 *
 *  @param __rType block返回参数类型
 *  @param __obj   NSObject *
 *
 *  @return __rType
 */
#define WGBLOCK(__rType,__obj,...) ((__rType(^)(__VA_ARGS__))[__obj wg_doBlock])
#endif

@interface NSObject (WGBlock)
//private:
- (void)wg_addBlock:(void *)block forKey:(const char *)pKey;
- (void *)wg_doBlockForKey:(const char *)pKey;

@property (nonatomic,setter=wg_addBlock:) void *wg_doBlock;
@end

/**
 *
 
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
 

 */
