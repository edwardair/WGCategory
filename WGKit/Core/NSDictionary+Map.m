//
//  NSDictionary+Map.m
//  WGCategory
//
//  Created by RayMi on 2018/1/20.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "NSDictionary+Map.h"

@implementation NSDictionary (Map)
- (instancetype)wg_map:(id (^)(id, NSString *))block{
    NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id mapped = block(obj,key);
        //如mapped存在，则添加入数组，可用于数组过滤
        if (mapped) {
            [tmp setObject:mapped forKey:key];
        }
    }];
    return tmp;
}
@end
