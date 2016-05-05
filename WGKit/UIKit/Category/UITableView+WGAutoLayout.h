//
//  UITableViewCell+WGLayout.h
//  MIFM
//
//  Created by RayMi on 15/12/19.
//  Copyright © 2015年 Roidmi. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  用于UITableViewCell使用autolayout自适应高度的封装
 */
@interface UITableView (WGAutoLayout)
- (id)wgDequeueReusableCellWithIdentifier:(NSString *)idfer;
@end
