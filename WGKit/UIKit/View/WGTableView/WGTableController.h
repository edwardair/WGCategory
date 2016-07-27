//
//  WGTableController.h
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WGTableController : NSObject
@property (nonatomic,assign,readonly) id delegate;
- (instancetype)initWithTable:(UITableView *)tableView delegate:(id )delegate;
@end


#pragma mark - Category
@interface WGTableController (DataSource)

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

#pragma mark - Replace
@interface WGTableController (Replace)
/**
 *  @see[WGTableController wg_replaceSelector:selector withNewSelector:selector]
 */
- (void)wg_replaceSelector:(SEL )selector;
/**
 *  在不需继承WGTableController的情况下，增加调用类实现UITableViewDelegat/UITableViewDataSource协议
 *
 *  @param selector    原协议方法
 *  @param newSelector 调用类中，真正实现协议的方法名
 */
- (void)wg_replaceSelector:(SEL )selector withNewSelector:(SEL )newSelector;
@end


