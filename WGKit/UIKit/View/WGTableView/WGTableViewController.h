//
//  WGTableViewController.h
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGTableView.h"
#import "WGTableViewModel.h"
#import "WGTableViewCell.h"
#import "NSArray+NSIndexPath.h"


@interface WGTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong,readonly) UITableView *tableView;
@property (nonatomic,strong,readonly) NSMutableArray *dataSource;/**< @[] if not used*/
@property (nonatomic,strong,readonly) NSMutableArray *cells;

- (NSMutableArray *)sectionAtIndex:(NSInteger )section;

- (void)addCells:(NSArray<UITableViewCell *> *)cells
       atSection:(NSInteger )section;
- (void)addCells:(NSArray<UITableViewCell *> *)cells
       atSection:(NSInteger )section
       animation:(UITableViewRowAnimation)animation;

- (void)insertCells:(NSArray<UITableViewCell *> *)cells
              atRow:(NSInteger )row
          inSection:(NSInteger )section;
- (void)insertCells:(NSArray<UITableViewCell *> *)cells
              atRow:(NSInteger )row
          inSection:(NSInteger )section
          animation:(UITableViewRowAnimation)animation;

- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *)indexes;
- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *)indexes
                   animation:(UITableViewRowAnimation)animation;

/**
 *  reload 重新批量刷新cell高度
 */
- (void)reloadAllCells;
- (void)reloadCellsForIndexes:(NSArray<NSIndexPath *> *)indexes;
- (void)reloadCells:(NSArray *)cells;
@end


