//
//  WGTableViewCell.h
//  WGCategory
//
//  Created by RayMi on 16/6/28.
//  Copyright © 2016年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ReloadBlock)(id cell_, id model_);

@interface UITableViewCell (DataManager)

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
@interface UITableViewCell (AutoLayoutHeight)
- (void)setNeedUpdateHeight;
- (void)updateHeightIfNeed;
@property (nonatomic,assign,readonly) BOOL didUpdateHeight;
/**
 *  当使用此数据值，需要确保cell的高度可以正确刷新，如需强制更新高度，则调用[cell setNeedUpdateHeight]
 */
@property (nonatomic,assign,readonly) CGFloat cellHeight;
@end
