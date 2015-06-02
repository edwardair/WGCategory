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
@property (nonatomic,assign) UIEdgeInsets edgeInsets;
@property (nonatomic,copy) WGTableViewEdgeInsetEnable enable;
@end
@implementation WGTableViewEdgeInset
@end

#pragma mark - UIViewController
@implementation UIViewController (Category)

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
    //MARK: 注销是为了 消除警告
//    else
//        self.wantsFullScreenLayout = NO;
}



#pragma mark - UITableView EdgeInsets
#define Start UITableView *

static const char *property_wg_edgeinsets = "property_wg_edgeinsets";
- (NSArray *)wg_edgeInsets{
    return [NSArray arrayWithArray:objc_getAssociatedObject(self, property_wg_edgeinsets)];
}
- (void)setWg_edgeInsets:(NSArray *)wg_edgeInsets{
    objc_setAssociatedObject(self, property_wg_edgeinsets, [NSArray arrayWithArray:wg_edgeInsets], OBJC_ASSOCIATION_RETAIN);
}
- (void)wg_setTableView:(UITableView *)table
      WithEdgeInsets:(UIEdgeInsets)edgeInsets
     CellChangeIfEnableAtIndexPath:(WGTableViewEdgeInsetEnable )enable{
    WGTableViewEdgeInset *model = [[WGTableViewEdgeInset alloc]init];
    model.tableView = table;
    model.edgeInsets = edgeInsets;
    model.enable = enable;
    
    WGTableViewEdgeInset *model_ = nil;
    NSArray *exists = [NSArray arrayWithArray:self.wg_edgeInsets];
    for (model_ in exists) {
        if ([model_.tableView isEqual:model.tableView] &&
            UIEdgeInsetsEqualToEdgeInsets(model_.edgeInsets, model.edgeInsets)
            ) {
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
        model_.enable = model.enable;
    }
    //调用viewDidLayoutSubviews
    [self.view setNeedsLayout];
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (void)viewDidLayoutSubviews{
    for (WGTableViewEdgeInset *model in self.wg_edgeInsets) {
        if (model.tableView) {
            if ([model.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
                [model.tableView setSeparatorInset:model.edgeInsets];
            }
            if ([model.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
                [model.tableView setLayoutMargins:model.edgeInsets];
            }
        }
    }
}

-(void)tableView:(UITableView *)tableView
 willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    for (WGTableViewEdgeInset *model in self.wg_edgeInsets) {
        if (model.tableView && model.enable(indexPath)) {
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                [cell setSeparatorInset:model.edgeInsets];
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                [cell setLayoutMargins:model.edgeInsets];
            }
        }
    }
}

#pragma clang diagnostic pop

@end



