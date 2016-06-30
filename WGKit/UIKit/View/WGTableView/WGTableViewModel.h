//
//  WGTableViewModel.h
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGTableViewModel : NSObject
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong,readonly) NSMutableArray *cells;
@end
