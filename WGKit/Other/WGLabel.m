//
//  WGLabel.m
//  WuXiAirport
//
//  Created by Apple on 14-3-20.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "WGLabel.h"
#import "WGDefines.h"
@implementation WGLabel

- (void)setText:(NSString *)text{
    [super setText:[NSString handleNetString:text]];
}


@end
