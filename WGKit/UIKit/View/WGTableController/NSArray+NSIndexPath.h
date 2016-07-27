//
//  NSArray+NSIndexPath.h
//  WGCategory
//
//  Created by RayMi on 16/6/30.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  仅配合WGTableController使用的定制扩展
 */
@interface NSArray (NSIndexPath)
/**
 *  根据长度生成NSIndexPath数组
 */
+ (NSArray<NSIndexPath *> *)indexPathsFromRow:(NSInteger)row
                                    inSection:(NSInteger)section
                                       length:(NSInteger)len;
/**
 *  【sections = NSArray<NSArray *> *】 二维数组，为UITableView.dataSource，所有section的数据源
 *
 *  @return 转化为包含所有cell的一维数组
 */
+ (NSArray<NSIndexPath *> *)indexPathsFromAllSections:(NSArray<NSArray *> *)sections;
/**
 *  【sections = NSArray<NSArray *> *】 二维数组，为UITableView.dataSource，所有section的数据源
 *
 *  @return 转化为包含所有cell的一维数组
 */
+ (NSArray<UITableViewCell *> *)cellsFromAllSections:(NSArray<NSArray *> *)sections;
/**
 *  indexes = NSArray<NSIndexPath *> *
 *
 *  @param 【cells = NSArray<NSArray *> *】 二维数组，为UITableView.dataSource，所有section的数据源
 *
 *  @return indexPath对应的cell，只有设置cell.indexPath后，
 */
+ (NSArray<UITableViewCell *> *)cellsForIndexPaths:(NSArray<NSIndexPath *> *)indexes
                                                in:(NSArray<NSArray *> *)cells;
@end
