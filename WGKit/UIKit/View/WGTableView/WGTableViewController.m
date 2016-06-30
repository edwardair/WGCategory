//
//  WGTableViewController.m
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import "WGTableViewController.h"
#import "WGDefines.h"
#import "NSArray+NSIndexPath.h"

#pragma mark -
@interface WGTableViewController ()
@end
@implementation WGTableViewController
@synthesize dataSource = _dataSource, cells = _cells, tableView = _tableView;

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (!self.tableView.delegate) {
        self.tableView.delegate = self;
    }
    if (!self.tableView.dataSource) {
        self.tableView.dataSource = self;
    }
}
#pragma mark - getter
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}
- (NSMutableArray *)cells{
    if (!_cells) {
        _cells = @[].mutableCopy;
        [_cells addObject:@[].mutableCopy];//默认始终至少有一个section
    }
    return _cells;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [self.view addSubview:_tableView];
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _tableView.tableFooterView = [UIView new];
        [self.view
         addConstraints:
         [NSLayoutConstraint
          constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|"
          options:0
          metrics:nil
          views:NSDictionaryOfVariableBindings(
                                               _tableView)]];
        [self.view
         addConstraints:
         [NSLayoutConstraint
          constraintsWithVisualFormat:@"V:|-0-[_tableView]-0-|"
          options:0
          metrics:nil
          views:NSDictionaryOfVariableBindings(
                                               _tableView)]];
        [self.view layoutIfNeeded];
    }
    return _tableView;
}

#pragma mark - Datasource
- (NSMutableArray *)sectionAtIndex:(NSInteger )section {
    NSInteger existSectionCount = self.cells.count;
    //当添加的section超出现有section数组，则添加中间空sections，以备后续填充
    if (section>=existSectionCount) {
        for (NSInteger i = existSectionCount; i < (section-existSectionCount); i++) {
            [self.cells addObject:@[].mutableCopy];
        }
    }
    return self.cells[section];
}

#pragma mark - add
- (void)addCells:(NSArray<UITableViewCell *> *)cells
       atSection:(NSInteger)section {
    [self addCells:cells atSection:section animation:UITableViewRowAnimationNone];
}
- (void)addCells:(NSArray<UITableViewCell *> *)cells
       atSection:(NSInteger)section
       animation:(UITableViewRowAnimation)animation {
    NSMutableArray *theSection = [self sectionAtIndex:section];
    
    NSMutableArray<NSIndexPath *> *indexes = @[].mutableCopy;
    NSInteger index = theSection.count;
    [theSection addObjectsFromArray:cells];
    
    for (NSInteger i = 0; i < cells.count; i++) {
        NSIndexPath *indexPath =
        [NSIndexPath indexPathForRow:index++ inSection:section];
        [indexes addObject:indexPath];
    }
    [self.tableView insertRowsAtIndexPaths:indexes withRowAnimation:animation];
}
#pragma mark - insert
- (void)insertCells:(NSArray<UITableViewCell *> *)cells
              atRow:(NSInteger)row
          inSection:(NSInteger)section {
  [self insertCells:cells
          atRow:row
          inSection:section
          animation:UITableViewRowAnimationLeft];
}
- (void)insertCells:(NSArray<UITableViewCell *> *)cells
              atRow:(NSInteger)row
          inSection:(NSInteger)section
          animation:(UITableViewRowAnimation)animation {
    NSMutableArray *theSection = [self sectionAtIndex:section];
    [theSection insertObjects:cells atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(row, cells.count)]];
    NSArray *indexes = [NSArray indexPathsFromRow:row
                                        inSection:section
                                           length:cells.count];
    [self.tableView insertRowsAtIndexPaths:indexes withRowAnimation:animation];
}
#pragma mark - delete
- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *)indexes {
    [self deleteCellsAtIndexes:indexes animation:UITableViewRowAnimationNone];
}
- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *)indexes
                   animation:(UITableViewRowAnimation)animation {
    for (NSInteger i = 0; i < indexes.count; i++) {
        NSIndexPath *indexPath = indexes[i];
        NSMutableArray *theSection = [self sectionAtIndex:indexPath.section];
        if (indexPath.row < theSection.count) {
            [theSection removeObjectAtIndex:indexPath.row];
        }
    }
    [self.tableView deleteRowsAtIndexPaths:indexes withRowAnimation:animation];
}
#pragma mark - reload
- (void)reloadAllCells{
    NSArray *cells = [self.cells cellsFromAllSections];
    [self reloadCells:cells];
}
- (void)reloadCellsForIndexes:(NSArray<NSIndexPath *> *)indexes {
    NSArray *cells = [indexes cellsForIndexPathsIn:self.cells];
    [self reloadCells:cells];
}
- (void)reloadCells:(NSArray *)cells {
    if (cells.count==0) {
        return;
    }
    for (UITableViewCell *cell in cells) {
        [cell setNeedUpdateHeight];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cells.count;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *theSection = self.cells[section];
    return theSection.count;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *theSection = [self sectionAtIndex:indexPath.section];
    UITableViewCell *cell = theSection[indexPath.row];
    if (!cell.didUpdateHeight) {
        cell.bounds = CGRectMake(0, 0, tableView.wg_width, cell.wg_height);
        [cell layoutIfNeeded];
        //需要再次强制刷新一次
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
    }
    return cell.cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *theSection = [self sectionAtIndex:indexPath.section];
    UITableViewCell *cell = theSection[indexPath.row];
    return cell ?: [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
