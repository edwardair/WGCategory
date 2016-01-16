//
//  NSArray+WGJSONModel.h
//  WGCategory
//
//  Created by RayMi on 16/1/16.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WGJSONModel)
/**
 *  将NSArray中的值，批量转化为aClass对应的MODEL
 *
 *  @param aClass
 *
 *  @return @[]
 */
- (NSArray *)batchModelsWithClass:(Class)aClass;
- (NSArray *)batchModelsWithClassName:(NSString *)className;
@end
