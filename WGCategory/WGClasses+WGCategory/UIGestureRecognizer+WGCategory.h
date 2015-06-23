//
//  WGGestureRecognizer.h
//  wuxigovapp
//
//  Created by Apple on 14-1-3.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

@interface UIGestureRecognizer(WGCategory)
#pragma mark - tag
- (int)wg_tag;
- (void)setWg_Tag:(int )tag;
@end
