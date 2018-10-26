//
//  WGTableViewEdgeInsets.m
//  WGCategory
//
//  Created by RayMi on 16/4/5.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableView+EdgeInsets.h"
#import <objc/runtime.h>
#import "NSObject+WGObject.h"


#pragma mark - MODEL
@interface WGTableViewEdgeInset:NSObject
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,copy) WGTableViewEdgeInsetsBlock edgeInsetsBlock;
@end
@implementation WGTableViewEdgeInset
@end

#pragma mark - NSObject - WGTableViewEdgeInsets
@interface NSObject (WGTableViewEdgeInsets)

@end
@implementation NSObject (WGTableViewEdgeInsets)

#pragma mark - UITableView EdgeInsets
static const char *property_wg_edgeinsets = "property_wg_edgeinsets";
- (NSArray *)wg_edgeInsets{
    return [NSArray arrayWithArray:objc_getAssociatedObject(self, property_wg_edgeinsets)];
}
- (void)setWg_edgeInsets:(NSArray *)wg_edgeInsets{
    objc_setAssociatedObject(self, property_wg_edgeinsets, [NSArray arrayWithArray:wg_edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)wg_setTableView:(UITableView *)table
  edgeInsetsAtIndexPath:(WGTableViewEdgeInsetsBlock)edgeInsets{
    WGTableViewEdgeInset *model = [[WGTableViewEdgeInset alloc]init];
    model.tableView = table;
    model.edgeInsetsBlock = edgeInsets;
    
    //修改UITableView.inset为UIEdgeInsetsZero，这样修改UITableViewCell.inset才可修改为UIEdgeInsetsZero
    if ([table respondsToSelector:@selector(setSeparatorInset:)]) {
        [table setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([table respondsToSelector:@selector(setLayoutMargins:)]) {
        [table setLayoutMargins:UIEdgeInsetsZero];
    }
    
    WGTableViewEdgeInset *model_ = nil;
    NSArray *exists = [NSArray arrayWithArray:self.wg_edgeInsets];
    for (model_ in exists) {
        if ([model_.tableView isEqual:model.tableView]) {
            break;
        }else{
            model_ = nil;
        }
    }
    
    if (!model_) {
        exists = [exists arrayByAddingObject:model];
        self.wg_edgeInsets = exists;
        
//        //动态exchange tableView:willDisplayCell:forRowAtIndexPath:方法
//        [[self class]swizzleExchangeInstanceAPI:@selector(tableView:willDisplayCell:forRowAtIndexPath:)
//                                    newSelector:@selector(mytableView:willDisplayCell:forRowAtIndexPath:)];
    }else{
        //更新
        model_.edgeInsetsBlock = model.edgeInsetsBlock;
    }
    
}

void wgtableviewEdgeInsets(NSObject *self, SEL _cmd, UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath){
    for (WGTableViewEdgeInset *model in self.wg_edgeInsets) {
        if ([model.tableView isEqual:tableView]) {
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                [cell setSeparatorInset:model.edgeInsetsBlock(indexPath)];
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:model.edgeInsetsBlock(indexPath)];
            }
        }
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
-(void)mytableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self mytableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    wgtableviewEdgeInsets(self, @selector(tableView:willDisplayCell:forRowAtIndexPath:), tableView, cell, indexPath);
}
#pragma clang diagnostic pop
@end


#pragma mark - UIView - WGTableViewEdgeInsets
@implementation UIView (WGTableViewEdgeInsets)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
-(void)tableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    wgtableviewEdgeInsets(self, @selector(tableView:willDisplayCell:forRowAtIndexPath:), tableView, cell, indexPath);
}
#pragma clang diagnostic pop
@end

#pragma mark - UIView - WGTableViewEdgeInsets
@implementation UIViewController (WGTableViewEdgeInsets)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
-(void)tableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    wgtableviewEdgeInsets(self, @selector(tableView:willDisplayCell:forRowAtIndexPath:), tableView, cell, indexPath);
}
#pragma clang diagnostic pop

@end

