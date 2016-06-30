//
//  TestTableViewCell.m
//  WGCategory
//
//  Created by RayMi on 16/6/30.
//  Copyright © 2016年 WG. All rights reserved.
//

#import "TestTableViewCell.h"
#import "WGDefines.h"
@implementation TestTableViewCell

- (void)awakeFromNib{
    _testLabel.backgroundColor = [UIColor orangeColor];
    self->_needUpdateWidthAfterLayout = ^(TestTableViewCell *weakCell){
        weakCell.testLabel.preferredMaxLayoutWidth = weakCell.testLabel.wg_width;
    };
}
- (id)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        _testLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_testLabel];
        self.contentView.backgroundColor = [UIColor colorWithRed:1.000 green:0.641 blue:1.000 alpha:1.000];
        _testLabel.numberOfLines = 0;
        _testLabel.clipsToBounds = YES;
        _testLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_testLabel setContentCompressionResistancePriority:751 forAxis:1];
        _testLabel.backgroundColor = [UIColor orangeColor];
        [self.contentView
         addConstraints:
         [NSLayoutConstraint
          constraintsWithVisualFormat:@"|-1-[_testLabel]-1-|"
          options:0
          metrics:nil
          views:NSDictionaryOfVariableBindings(_testLabel)]];
        [self.contentView
         addConstraints:
         [NSLayoutConstraint
          constraintsWithVisualFormat:@"V:|-1-[_testLabel]-1@1000-|"
          options:0
          metrics:nil
          views:NSDictionaryOfVariableBindings(_testLabel)]];

        self->_needUpdateWidthAfterLayout = ^(TestTableViewCell *weakCell){
            weakCell.testLabel.preferredMaxLayoutWidth = weakCell.testLabel.wg_width;
        };
    }
    return self;
}


@end
