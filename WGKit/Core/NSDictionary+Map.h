//
//  NSDictionary+Map.h
//  WGCategory
//
//  Created by RayMi on 2018/1/20.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Map)
- (instancetype)wg_map:(id(^)(id obj,NSString *key))block;
@end
