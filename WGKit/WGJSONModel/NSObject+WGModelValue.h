//
//  NSObject+WGModelValue.h
//  WGCategory
//
//  Created by RayMi on 15/6/15.
//  Copyright (c) 2015年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WGModelValueKeysFilterProtocol
@required
- (NSArray<NSString *> *_Nullable)wg_filterKeys;
@end

@interface NSString (WGModelValueKeysFilter) <WGModelValueKeysFilterProtocol>
@end
@interface NSDictionary (WGModelValueKeysFilter) <WGModelValueKeysFilterProtocol>
@end
@interface NSArray (WGModelValueKeysFilter) <WGModelValueKeysFilterProtocol>
/// 下一级过滤keys
/// @param curKey 第一级key，如key对应为NSString(self)，则返回空，如key对应为NSDictionary，则返回字典中key对应的value
- (NSArray<WGModelValueKeysFilterProtocol> * _Nullable)wg_filterKeys_next:(NSString *_Nullable)curKey;//下一级过滤keys
@end
@interface NSObject (WGModelValueKeysFilter) <WGModelValueKeysFilterProtocol>
@end

/**
 *  model转NSDictionary、NSArray
 */
@interface NSObject (WGModelValue)
- (id _Nullable )modelValue;

/// model 转 value
/// @param keys 仅获取keys对应的值，不支持多级递归
- (id _Nullable )modelValueForKeys:(NSArray<WGModelValueKeysFilterProtocol> *_Nullable)keys;
@end
