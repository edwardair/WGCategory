//
//  WGTableViewController.h
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (WGTableViewController)<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *wg_tableView;
@property (nonatomic,strong,readonly) NSMutableArray *wg_dataSource;/**< @[] if not used*/
/**
 *
 */
@property (nonatomic,strong,readonly) NSMutableArray *wg_cells;/**< 通过以下定义方法增加cell*/

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

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
/**
 *  当使用cell的复用机制时，需要确保cell的高度可以正确刷新 @see[UITableViewCell setNeedUpdateHeight]
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


