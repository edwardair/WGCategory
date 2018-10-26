//
//  NSArray+Map.m
//  WGCategory
//
//  Created by RayMi on 2018/1/20.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "NSArray+Map.h"

@implementation NSArray (Map)
- (instancetype)wg_map:(id (^)(id,NSUInteger))block{
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id mapped = block(obj,idx);
        //如mapped存在，则添加入数组，可用于数组过滤
        if (mapped) {
            [tmp addObject:mapped];
        }
    }];
    return tmp;
}
@end
