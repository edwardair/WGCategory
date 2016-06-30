//
//  WGTableViewCell.m
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import "WGTableViewCell.h"
@interface WGTableViewCell()
@end

@implementation WGTableViewCell
- (void)layoutSubviews{
    [super layoutSubviews];
    if (_needUpdateWidthAfterLayout) {
        _needUpdateWidthAfterLayout(self);
    }
}
- (void)loadModel:(id)model doReload:(ReloadBlock)block {
    _model = model;
    _reloadBlock = block;
    if (block) {
        block(self, model);
    }
}
- (void)updateModel:(id )model {
    _model = model;
    if (_reloadBlock) {
        _reloadBlock(self,model);
    }
}
@end

#pragma mark -
#import <objc/runtime.h>

static const char key_did_update_height;
static const char key_cell_height;

@interface UITableViewCell()
@property (nonatomic,assign) BOOL didUpdateHeight;
@property (nonatomic,assign) CGFloat cellHeight;
@end
@implementation UITableViewCell (InnerValue)
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

#pragma mark -
static const char key_index_path;
@implementation UITableViewCell (IndexPath)
//- (NSIndexPath *)indexPath{
//    return objc_getAssociatedObject(self, &key_index_path);
//}
//- (void)setIndexPath:(NSIndexPath *)indexPath{
//    objc_setAssociatedObject(self, &key_index_path, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
@end

#pragma mark -
@implementation UITableViewCell (AutoLayout)
- (void)setNeedUpdateHeight{
    self.didUpdateHeight = NO;
}
- (void)updateHeightIfNeed {
    if (!self.didUpdateHeight) {
        CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        height += 1.f;
        self.cellHeight = height;
        self.didUpdateHeight = YES;
    }
}

@end





