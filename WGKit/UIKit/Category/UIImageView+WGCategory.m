//
//  UIImageView+WGImageView.h
//
//  Created by Apple on 14-1-15.
//  Copyright (c) 2014年 Apple. All rights reserved.
//


#import "UIView+WGCategory.h"

@implementation UIImageView (WGCategory)
#pragma mark - copy zone
- (id )copyWithZone:(NSZone *)zone{
    UIImageView *newView = [super copyWithZone:zone];
    //TODO: UIImageView  带 self.image copy，会有遗留图片的问题(未解决，暂时注释掉)
//    newView.image = self.image;
//    newView.highlightedImage = self.highlightedImage;
    return newView;
}
@end
