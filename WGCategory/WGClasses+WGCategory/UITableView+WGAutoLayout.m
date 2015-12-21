//
//  UITableViewCell+WGLayout.m
//  MIFM
//
//  Created by RayMi on 15/12/19.
//  Copyright © 2015年 Roidmi. All rights reserved.
//

#import "UITableView+WGAutoLayout.h"

@implementation UITableView (WGAutoLayout)
- (id )wgDequeueReusableCellWithIdentifier:(NSString *)idfer{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:idfer];
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(cell.bounds));
    [cell layoutIfNeeded];
    return cell;
}
@end
