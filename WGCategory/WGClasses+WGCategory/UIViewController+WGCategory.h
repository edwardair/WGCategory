//
//  UIViewController+WGViewController.h
//  WGCategory
//
//  Created by Apple on 13-12-31.
//  Copyright (c) 2013年 Apple. All rights reserved.
//


@interface UIViewController (WGCategory)
- (void)disableAutoAdjustScrollViewInsets;
- (void)disableExtendedLayoutFull;


#pragma mark - UITableView EdgeInsets
typedef BOOL (^WGTableViewEdgeInsetEnable) (NSIndexPath *indexPath);
@property (nonatomic,strong) NSArray *wg_edgeInsets;
/**
 *  修改UITableView.seperateInsets
 *
 *  @param table      UITableView
 *  @param edgeInsets UIEdgeinsets，当多次调用此方法时，inset相同，则只更新block，如果不同，则增加多个inset，配合enable使用，
                    控制cell.sepectInsets
 *  @param enable     根据需要，针对某个cell才启用修改
 */
- (void)wg_setTableView:(UITableView *)table
      WithEdgeInsets:(UIEdgeInsets)edgeInsets
              CellChangeIfEnableAtIndexPath:(WGTableViewEdgeInsetEnable )enable;

@end

