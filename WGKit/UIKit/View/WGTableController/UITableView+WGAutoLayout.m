//
//  UITableViewCell+WGLayout.m
//  MIFM
//
//  Created by RayMi on 15/12/19.
//  Copyright © 2015年 Roidmi. All rights reserved.
//

#import "UITableView+WGAutoLayout.h"
#import "UITableViewCell+WGAutoLayout.h"
#import "UIView+WGCategory.h"

@implementation UITableView (WGAutoLayout)
- (id )wgDequeueReusableCellWithIdentifier:(NSString *)idfer{
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:idfer];
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(cell.bounds));
    [cell layoutIfNeeded];
    return cell;
}

- (CGFloat)heightOfCellAtIndexPath:(NSIndexPath *)indexPath forceUpdate:(BOOL)force{
    UITableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return 0;
    }
    
    if (force) {
        [cell setNeedUpdateHeight];
    }
    
    if (!cell.didUpdateHeight) {
        cell.bounds = CGRectMake(0, 0, self.wg_width, cell.wg_height);
        [cell layoutIfNeeded];
    }

    CGFloat height = [cell cellHeight];
    return height;
}
@end
