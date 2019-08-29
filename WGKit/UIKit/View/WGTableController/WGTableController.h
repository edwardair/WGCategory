//
//  WGTableController.h
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGTableController : NSObject
+ (void)replaceSelector:(SEL _Nonnull )selector;

@property (nonatomic,assign,readonly) id _Nullable delegate;
- (instancetype _Nonnull )initWithTable:(UITableView *_Nullable)tableView delegate:(id _Nonnull )delegate;

@property (nonatomic,readonly) NSInteger sections;
@property (nonatomic,readonly) NSInteger(^ _Nonnull rows)(NSInteger atSection);
@end


#pragma mark - Category
@interface WGTableController (DataSource)
//根据section，获取一组cell
- (NSMutableArray<UITableViewCell *> *_Nonnull(^_Nonnull)(NSInteger))sectionAtIndex;
//获取指定cell对应的indexPath
- (NSArray<NSIndexPath *> *_Nonnull)indexPathesFor:(NSArray<UITableViewCell *> *_Nonnull)cells in:(NSInteger )section;

- (void)reloadData;
- (void)addCells:(NSArray<UITableViewCell *> *_Nonnull)cells
       atSection:(NSInteger )section;
- (void)addCells:(NSArray<UITableViewCell *> *_Nonnull)cells
       atSection:(NSInteger )section
       animation:(UITableViewRowAnimation)animation;

- (void)insertCells:(NSArray<UITableViewCell *> *_Nonnull)cells
              atRow:(NSInteger )row
          inSection:(NSInteger )section;
- (void)insertCells:(NSArray<UITableViewCell *> *_Nonnull)cells
              atRow:(NSInteger )row
          inSection:(NSInteger )section
          animation:(UITableViewRowAnimation)animation;

- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *_Nonnull)indexes;
- (void)deleteCellsAtIndexes:(NSArray<NSIndexPath *> *_Nonnull)indexes
                   animation:(UITableViewRowAnimation)animation;

/**
 *  reload 重新批量刷新cell高度
 */
- (void)updateHeightOfAllCells;
- (void)updateHeightAtIndexes:(NSArray<NSIndexPath *> *_Nonnull)indexes;

@end

#pragma mark - Replace
@interface WGTableController (Replace)
/**
 *  @see[WGTableController wg_replaceSelector:selector withNewSelector:selector]
 */
- (void)wg_replaceSelector:(SEL _Nonnull )selector;
/**
 *  在不需继承WGTableController的情况下，增加调用类实现UITableViewDelegat/UITableViewDataSource协议
 *
 *  @param selector    原协议方法
 *  @param newSelector 调用类中，真正实现协议的方法名
 */
- (void)wg_replaceSelector:(SEL _Nonnull )selector withNewSelector:(SEL _Nonnull )newSelector;

@end


