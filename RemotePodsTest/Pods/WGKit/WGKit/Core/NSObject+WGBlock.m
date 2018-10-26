//
//  NSObject+WGBlock.m
//  WGCategory
//
//  Created by RayMi on 17/4/11.
//  Copyright © 2017年 WG. All rights reserved.
//

#import "NSObject+WGBlock.h"
#import <objc/runtime.h>
@implementation NSObject (WGBlock)
- (void)wg_addBlock:(void *)block forKey:(const char *)pKey{
    objc_setAssociatedObject(self, pKey, (__bridge id)(block), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void *)wg_doBlockForKey:(const char *)pKey{
    void (^block)(void) = objc_getAssociatedObject(self, pKey);
    return (__bridge void *)(block);
}

#pragma mark - tmp block
const char *wg_tmp_block = "wg_tmp_block";
- (void)wg_addBlock:(void *)block{
    [self wg_addBlock:block forKey:wg_tmp_block];
}
- (void *)wg_doBlock{
    return [self wg_doBlockForKey:wg_tmp_block];
}
@end
