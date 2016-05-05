//
//  NSArray+WGJSONModel.h
//  WGCategory
//
//  Created by RayMi on 16/1/16.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  将NSArray中的值，批量转化为aClass对应的MODEL
 */
@interface NSArray (WGJSONModel_Batch) 
- (NSArray *)batchModelsWithClass:(Class)aClass;
- (NSArray *)batchModelsWithClassName:(NSString *)className;
@end
