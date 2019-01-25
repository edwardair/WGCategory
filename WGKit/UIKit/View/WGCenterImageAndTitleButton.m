//
//  WGCenterImageAndTitleButton.m
//  RoidmiFM
//
//  Created by RayMi on 16/7/14.
//  Copyright © 2016年 Roidmi. All rights reserved.
//

#import "WGCenterImageAndTitleButton.h"

@implementation WGCenterImageAndTitleButton
-  (void)setup{
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}
- (id)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize intrinsicContentSize = self.intrinsicContentSize;
    self.imageEdgeInsets = UIEdgeInsetsMake(
                                            0, (intrinsicContentSize.width - self.imageView.bounds.size.width) / 2,
                                            0,
                                            -(intrinsicContentSize.width - self.imageView.bounds.size.width) / 2);
    self.titleEdgeInsets = UIEdgeInsetsMake(
                                            self.imageView.bounds.size.height + _verticalSpacing,
                                            -((self.imageView.bounds.size.width+self.titleLabel.bounds.size.width/2)-(MAX(self.imageView.image.size.width, self.titleLabel.bounds.size.width))/2),
                                            0,
                                            0);
}
- (CGSize)intrinsicContentSize{
    UIImageView *imageView = self.imageView;
    UILabel *titleLabel = self.titleLabel;
    [imageView sizeToFit];
    [titleLabel sizeToFit];
    return CGSizeMake(
                      MAX(imageView.image.size.width, titleLabel.bounds.size.width),
                      imageView.image.size.height + titleLabel.bounds.size.height + _verticalSpacing);
}
@end
