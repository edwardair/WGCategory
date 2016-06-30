//
//  TestTableViewCell.h
//  WGCategory
//
//  Created by RayMi on 16/6/30.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGTableViewCell.h"

@interface TestTableViewCell : WGTableViewCell
@property (nonatomic,strong) UILabel *testLabel;
@property (nonatomic,assign) BOOL shortText;
@end
