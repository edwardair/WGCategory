//
//  WGTableViewCell.h
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^UpdateWidthAfterLayout) (id weakCell);
typedef void(^ReloadBlock)(id cell_, id model_);
@interface WGTableViewCell : UITableViewCell{
    /**
     *  仅限子类内部使用
     *  用于layoutSubviews之后，更新UILabel.preferredMaxLayoutWidth
     */
    UpdateWidthAfterLayout _needUpdateWidthAfterLayout;
}

@property (nonatomic,strong,readonly) id model;
@property (nonatomic,copy) ReloadBlock reloadBlock;
/**
 *  加载数据
 *
 *  @param model
 *  @param block 处理具体cell的数据加载
 */
- (void)loadModel:(id)model doReload:(ReloadBlock )block;
/**
 *  更新model，当tableView reload时，将会通过ReloadBlock 回调
 */
- (void)updateModel:(id )model;
@end

#pragma mark -
@interface UITableViewCell (InnerValue)
@property (nonatomic,assign,readonly) BOOL didUpdateHeight;
@end

#pragma mark -
@interface UITableViewCell (IndexPath)
//@property (nonatomic,strong) NSIndexPath *indexPath;
@end

#pragma mark -
@interface UITableViewCell (AutoLayout)
- (void)setNeedUpdateHeight;
- (void)updateHeightIfNeed;
@property (nonatomic,assign,readonly) CGFloat cellHeight;
@end