//
//  WGTableViewController.h
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGTableView.h"
#import "WGTableViewCell.h"
#import "NSArray+NSIndexPath.h"

@interface WGTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong,readonly) UITableView *tableView;/**< 默认为满屏宽高*/
@property (nonatomic,strong,readonly) NSMutableArray *dataSource;/**< @[] if not used*/
@property (nonatomic,strong,readonly) NSMutableArray *cells;/**< 通过以下定义方法增加cell*/

/**
 *  安全获取某个section，如果section之前的不存在，则会创建空section
 */
- (NSMutableArray *(^)(NSInteger))sectionAtIndex;

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
- (void)updateHeightOfAllCells;
- (void)updateHeightAtIndexes:(NSArray<NSIndexPath *> *)indexes;
@end

