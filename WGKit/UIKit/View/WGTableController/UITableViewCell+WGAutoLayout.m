//
//  WGTableViewCell.m
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import "UITableViewCell+WGAutoLayout.h"
#import <objc/runtime.h>
#import "NSObject+WGObject.h"

@interface UITableViewCell ()
@property (nonatomic,strong) id model;
@end

static const char key_cell_model;
static const char key_cell_reloadModel;

@implementation UITableViewCell (DataManager)

#pragma mark - getter
- (id )model{
    return objc_getAssociatedObject(self, &key_cell_model);
}
- (ReloadBlock)reloadBlock{
    return objc_getAssociatedObject(self, &key_cell_reloadModel);
}

#pragma mark - setter
- (void)setModel:(id)model{
    objc_setAssociatedObject(self, &key_cell_model, model, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setReloadBlock:(ReloadBlock)reloadBlock{
    objc_setAssociatedObject(self, &key_cell_reloadModel, reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark -
- (void)loadModel:(id)model doReload:(ReloadBlock)block {
    self.model = model;
    self.reloadBlock = block;
    !block?:block(self, model);
}

- (void)updateModel:(id )model {
    self.model = model;
    !self.reloadBlock?:self.reloadBlock(self,model);
}

@end


#pragma mark -

static const char key_did_update_height;
static const char key_cell_height;

@interface UITableViewCell()
@property (nonatomic,assign) CGFloat cellHeight;
@end

@implementation UITableViewCell (AutoLayout)
- (void)setNeedUpdateHeight{
    self.didUpdateHeight = NO;
}
- (void)updateHeightIfNeed {
    if (!self.didUpdateHeight) {
        //需要强制刷新一次
        [self setNeedsLayout];
        [self layoutIfNeeded];

        CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 1.f;
        self.cellHeight = height;
        self.didUpdateHeight = YES;
    }
}

- (BOOL)didUpdateHeight{
    id value = objc_getAssociatedObject(self, &key_did_update_height);
    return [value boolValue];
}
- (void)setDidUpdateHeight:(BOOL)didUpdateHeight{
    objc_setAssociatedObject(self, &key_did_update_height, @(didUpdateHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCellHeight:(CGFloat)cellHeight{
    objc_setAssociatedObject(self, &key_cell_height, @(cellHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)cellHeight{
    [self updateHeightIfNeed];
    return [objc_getAssociatedObject(self, &key_cell_height) floatValue];
}
@end





