//
//  NSArray+WGJSONModel.m
//  WGCategory
//
//  Created by RayMi on 16/1/16.
//  Copyright © 2016年 WG. All rights reserved.
//

#import "NSArray+WGJSONModel.h"
#import "NSObject+WGJSONModel.h"
@implementation NSArray (WGJSONModel_Batch)
- (NSArray *)batchModelsWithClass:(Class)aClass{
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:self.count];
    for (id value in self) {
        [models addObject:MODELWITHVALUE(value, aClass)];
    }
    return models;
}
- (NSArray *)batchModelsWithClassName:(NSString *)className{
    return [self batchModelsWithClass:NSClassFromString(className)];
}

@end
