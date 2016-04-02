//
//  UIViewController+WGViewController.m
//  WGCategory
//
//  Created by Apple on 13-12-31.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "WGDefines.h"
#import <objc/runtime.h>
#pragma mark - MODEL
@interface WGTableViewEdgeInset:NSObject
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) WGTableViewEdgeInsetsBlock edgeInsetsBlock;
@end
@implementation WGTableViewEdgeInset
@end

#pragma mark - UIViewController
@interface UIViewController()
@property (nonatomic,strong) NSArray *wg_edgeInsets;
@end
@implementation UIViewController (WGCategory)

#ifdef InFrameTestMode
#pragma mark - InFrameTestMode frame测试模式

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewWillAppear:(BOOL)animated{
    [WGFrameTest shareFrameTestWithViewController:self];
}
#pragma clang diagnostic pop

#endif

- (void)disableAutoAdjustScrollViewInsets{
    if ([UIDevice isIOS7Version])
        self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)disableExtendedLayoutFull{
    if ([UIDevice isIOS7Version])
        self.edgesForExtendedLayout = UIRectEdgeNone;
}



#pragma mark - UITableView EdgeInsets

static const char *property_wg_edgeinsets = "property_wg_edgeinsets";
- (NSArray *)wg_edgeInsets{
    return [NSArray arrayWithArray:objc_getAssociatedObject(self, property_wg_edgeinsets)];
}
- (void)setWg_edgeInsets:(NSArray *)wg_edgeInsets{
    objc_setAssociatedObject(self, property_wg_edgeinsets, [NSArray arrayWithArray:wg_edgeInsets], OBJC_ASSOCIATION_RETAIN);
}
- (void)wg_setTableView:(UITableView *)table
edgeInsetsAtIndexPath:(WGTableViewEdgeInsetsBlock)edgeInsets{
    WGTableViewEdgeInset *model = [[WGTableViewEdgeInset alloc]init];
    model.tableView = table;
    model.edgeInsetsBlock = edgeInsets;
    
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
    }else{
        //更新
        model_.edgeInsetsBlock = model.edgeInsetsBlock;
    }
    //调用viewDidLayoutSubviews
    [self.view setNeedsLayout];
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

NSIndexPath *wgFirstStaticIndexPath(){
    static NSIndexPath *wgFirstStaticIndexPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wgFirstStaticIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    });
    return wgFirstStaticIndexPath;
}

- (void)viewDidLayoutSubviews{
    for (WGTableViewEdgeInset *model in self.wg_edgeInsets) {
        if (model.tableView) {
            if ([model.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
                [model.tableView setSeparatorInset:model.edgeInsetsBlock(wgFirstStaticIndexPath())];
            }
            if ([model.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
                [model.tableView setLayoutMargins:model.edgeInsetsBlock(wgFirstStaticIndexPath())];
            }
        }
    }
}

-(void)tableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
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

#pragma clang diagnostic pop

@end



