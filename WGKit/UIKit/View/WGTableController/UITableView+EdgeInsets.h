//
//  WGTableViewEdgeInsets.h
//  WGCategory
//
//  Created by RayMi on 16/4/5.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UIEdgeInsets (^WGTableViewEdgeInsetsBlock) (NSIndexPath *indexPath);

#pragma mark -
@protocol WGTableViewEdgeInsetsProtocol <NSObject>
@optional
/**
 *  修改UITableView.seperateInsets
 *
 *  @param table      UITableView
 *  @param edgeInsets UIEdgeinsets，当多次调用此方法时，inset相同，则只更新block，如果不同，则增加多个inset，配合enable使用，
 控制cell.sepectInsets
 */
- (void)wg_setTableView:(UITableView *)table
  edgeInsetsAtIndexPath:(WGTableViewEdgeInsetsBlock )edgeInsets;
@end


@interface UIView (WGTableViewEdgeInsets)<WGTableViewEdgeInsetsProtocol>
@end

@interface UIViewController (WGTableViewEdgeInsets)<WGTableViewEdgeInsetsProtocol>
@end


