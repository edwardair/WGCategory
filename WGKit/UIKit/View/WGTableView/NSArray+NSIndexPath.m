//
//  NSArray+NSIndexPath.m
//  WGCategory
//
//  Created by RayMi on 16/6/30.
//  Copyright © 2016年 WG. All rights reserved.
//

#import "NSArray+NSIndexPath.h"
#import "WGTableViewCell.h"
@implementation NSArray (NSIndexPath)
+ (NSArray<NSIndexPath *> *)indexPathsFromRow:(NSInteger)row
                                    inSection:(NSInteger)section
                                       length:(NSInteger)len{
    NSMutableArray<NSIndexPath *> *indexes = @[].mutableCopy;
    for (NSInteger i = 0; i < len; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row+i inSection:section];
        [indexes addObject:indexPath];
    }
    return indexes;
}
- (NSArray<UITableViewCell *> *)cellsFromAllSections{
    NSMutableArray *cells = @[].mutableCopy;
    for (NSArray *tmp in self) {
        if ([tmp isKindOfClass:[NSArray class]]) {
            [cells addObjectsFromArray:tmp];
        }
    }
    return cells;
}
- (NSArray<UITableViewCell *> *)cellsForIndexPathsIn:(NSArray<NSArray *> *)cells{
    NSMutableArray<UITableViewCell *> *tmp = @[].mutableCopy;
    for (NSIndexPath *indexPath in self) {
        NSInteger section = indexPath.section;
        if (section<cells.count) {
            NSArray *theSection = cells[section];
            NSInteger row = indexPath.row;
            if (row<theSection.count) {
                UITableViewCell *theCell = theSection[row];
                [tmp addObject:theCell];
            }
        }
    }
    return tmp;
}
@end
