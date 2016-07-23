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
#import "UITableView+WGAutoLayout.h"
#import "UITableViewCell+WGAutoLayout.h"
#import "NSArray+NSIndexPath.h"
#import <objc/runtime.h>
#import <objc/message.h>
#pragma mark -


@interface WGTableView : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) id delegate;
@end
@implementation WGTableView

- (instancetype)initWithTable:(UITableView *)tableView delegate:(id )delegate;{
    CouldInitialized_Init
    
    _delegate = delegate;
    
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return self;
}

- (void)wg_selector:(SEL )selector forProtocol:(Protocol *)protocol{
    
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    return YES;
//}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    //进入此方法，则表示方法还未添加
    
    //TODO: 检测aSelector是否为UITableVieDelegate或者UITableViewDataSource协议
    
    return _delegate;
    
}
@end








static const char *key_wg_tableView;
static const char *key_wg_dataSource;
static const char *key_wg_cells;

@interface UIViewController ()
@property (nonatomic,strong) NSMutableArray *wg_dataSource;/**< @[] if not used*/
@property (nonatomic,strong) NSMutableArray *wg_cells;/**< 通过以下定义方法增加cell*/
@end

@implementation UIViewController (WGTableViewController)

#pragma mark - getter
- (UITableView *)wg_tableView{
    return objc_getAssociatedObject(self, &key_wg_tableView);
}
- (NSMutableArray *)wg_dataSource{
    NSMutableArray *tmp = objc_getAssociatedObject(self, &key_wg_dataSource);
    if (!tmp) {
        tmp = @[].mutableCopy;
        self.wg_dataSource = tmp;
    }
    return tmp;
}
- (NSMutableArray *)wg_cells{
    NSMutableArray *tmp = objc_getAssociatedObject(self, &key_wg_cells);
    if (!tmp) {
        tmp = @[].mutableCopy;
        [tmp addObject:@[].mutableCopy];//默认始终至少有一个section
        self.wg_cells = tmp;
    }
    return tmp;
}


#pragma mark - setter
- (void)setWg_tableView:(UITableView *)wg_tableView{
    objc_setAssociatedObject(self, &key_wg_tableView, wg_tableView, OBJC_ASSOCIATION_RETAIN);
    if (!wg_tableView.delegate) wg_tableView.delegate = self;
    if (!wg_tableView.dataSource) wg_tableView.dataSource = self;
}
- (void)setWg_dataSource:(NSMutableArray *)wg_dataSource{
    objc_setAssociatedObject(self, &key_wg_dataSource, wg_dataSource, OBJC_ASSOCIATION_RETAIN);
}
- (void)setWg_cells:(NSMutableArray *)wg_cells{
    objc_setAssociatedObject(self, &key_wg_cells, wg_cells, OBJC_ASSOCIATION_RETAIN);
}


#pragma mark - Datasource
- (NSMutableArray *(^)(NSInteger))sectionAtIndex{
    return ^ NSMutableArray *(NSInteger section){
        NSInteger existSectionCount = self.wg_cells.count;
        //当添加的section超出现有section数组，则添加中间空sections，以备后续填充
        if (section>=existSectionCount) {
            for (NSInteger i = existSectionCount; i < (section-existSectionCount); i++) {
                [self.wg_cells addObject:@[].mutableCopy];
            }
        }
        return self.wg_cells[section];
    };
}


#pragma mark - add
- (void)addCells:(NSArray<UITableViewCell *> *)cells
       atSection:(NSInteger)section {
    [self addCells:cells atSection:section animation:UITableViewRowAnimationNone];
}
- (void)addCells:(NSArray<UITableViewCell *> *)cells
       atSection:(NSInteger)section
       animation:(UITableViewRowAnimation)animation {
    NSMutableArray *theSection = self.sectionAtIndex(section);
    
    NSInteger row = theSection.count;
    [theSection addObjectsFromArray:cells];
    
    NSArray<NSIndexPath *> *indexes =
    [NSArray indexPathsFromRow:row inSection:section length:cells.count];
    
    [self.wg_tableView insertRowsAtIndexPaths:indexes withRowAnimation:animation];
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
    NSMutableArray *theSection = self.sectionAtIndex(section);
    [theSection insertObjects:cells atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(row, cells.count)]];
    NSArray *indexes = [NSArray indexPathsFromRow:row
                                        inSection:section
                                           length:cells.count];
    [self.wg_tableView insertRowsAtIndexPaths:indexes withRowAnimation:animation];
}


#pragma mark - delete
- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *)indexes {
    [self deleteCellsAtIndexes:indexes animation:UITableViewRowAnimationNone];
}
- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *)indexes
                   animation:(UITableViewRowAnimation)animation {
    for (NSInteger i = 0; i < indexes.count; i++) {
        NSIndexPath *indexPath = indexes[i];
        NSMutableArray *theSection = self.sectionAtIndex(indexPath.section);
        if (indexPath.row < theSection.count) {
            [theSection removeObjectAtIndex:indexPath.row];
        }
    }
    [self.wg_tableView deleteRowsAtIndexPaths:indexes withRowAnimation:animation];
}


#pragma mark - reload
- (void)updateHeightOfAllCells{
    NSArray<NSIndexPath *> *indexPaths = [NSArray indexPathsFromAllSections:self.wg_cells];
    [self updateHeightAtIndexes:indexPaths];
}
- (void)updateHeightAtIndexes:(NSArray<NSIndexPath *> *)indexes {
    if (indexes.count==0) {
        return;
    }
    NSArray *cells = [NSArray cellsForIndexPaths:indexes in:self.wg_cells];
    [cells makeObjectsPerformSelector:@selector(setNeedUpdateHeight)];

    void(^reload)() = ^(){
        [self.wg_tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationNone];
        //MARK: 必须多调用一次，UI才会正确刷新，如果用reload，则只需一遍即可，但动画很生硬，不知道是否是系统BUG
        [self.wg_tableView reloadRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationNone];
    };
    reload();
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.wg_cells.count;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *theSection = self.wg_cells[section];
    return theSection.count;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return 0;
    }
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
    NSMutableArray *theSection = self.sectionAtIndex(indexPath.section);
    UITableViewCell *cell = theSection[indexPath.row];
    return cell ?: [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
