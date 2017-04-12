//
//  CheckBox.m
//  wuxi
//
//  Created by Apple on 13-7-18.
//  Copyright (c) 2013年 gitmac. All rights reserved.
//

#import "WGCheckBox.h"
@interface WGCheckBox()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
/**
 为此box设置关联组，在box选中时，将其关联的所有box设置为非选中
 */
@property (nonatomic,strong) NSMutableArray *connectedBoxes;

@end
@implementation WGCheckBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isSelected = NO;
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont systemFontOfSize:12.f];
        self.connectedBoxes = [NSMutableArray array];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.isSelected = NO;
    self.backgroundColor = [UIColor clearColor];
    self.font = [UIFont systemFontOfSize:12.f];
    self.connectedBoxes = [NSMutableArray array];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //imageView  跟 titleLabel，宽度自适应，高度为满格
    
    //计算  imageView剩余宽度
    CGFloat w_imageView = [self.imageView sizeThatFits:self.bounds.size].width;
    
    //计算titLabel适应的宽
    CGFloat w_labelWidth = self.titleLabel.bounds.size.width;
    
    w_imageView = w_imageView>(CGRectGetWidth(self.bounds)-w_labelWidth)?(CGRectGetWidth(self.bounds)-w_labelWidth):w_imageView;//imageView的宽度视w_labelWidth而确定最大适应宽度
    
    CGFloat gap = (w_imageView+w_labelWidth)>CGRectGetWidth(self.bounds)?0:MIN(10.f, (CGRectGetWidth(self.bounds)-w_imageView-w_labelWidth));
    
    //居中平铺
    CGFloat left_Total = (CGRectGetWidth(self.bounds)-(w_imageView+w_labelWidth+gap))/2;
    
    self.imageView.frame = CGRectMake(left_Total, 0, w_imageView, CGRectGetHeight(self.bounds));
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+gap, 0, w_labelWidth, CGRectGetHeight(self.bounds));
    
}


#pragma mark - setter
- (void)setConnectedBoxes:(NSMutableArray *)connectedBoxes{
#if __has_feature(objc_mrc)
    [_connectedBoxes release];
    _connectedBoxes = nil;
    _connectedBoxes = [connectedBoxes retain];
#else
    _connectedBoxes = connectedBoxes;
#endif
}
- (void)setAppendConnectBox:(WGCheckBox *)appendConnectBox{
    /**
    	如果关联的是自己  则不关联
     */
    if ([appendConnectBox isEqual:self])
        return;
    
    /**
    	如果将要关联的appendConnectBox存在，则怎不继续关联
     */
    for (WGCheckBox *box in self.connectedBoxes) {
        if ([appendConnectBox isEqual:box]) {
            return;
        }
    }
    
    /**
    	添加关联
     */
    [self.connectedBoxes addObject:appendConnectBox];
    
    /**
    	把自己关联给appendConnectBox
     */
    appendConnectBox.appendConnectBox = self;
    
    /**
    	把自己所关联的所有appendConnectBox(包含appendConnectBox自己)关联给appendConnectBox
     */
    for (WGCheckBox *box in self.connectedBoxes) {
        appendConnectBox.appendConnectBox = box;
    }
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = _image;
    
}
- (void)setHighlightImage:(UIImage *)highlightImage{
    _highlightImage = highlightImage;
    
    self.imageView.highlightedImage = _highlightImage;

}
- (void)setText:(NSString *)text{
    self.titleLabel.text = text;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}
- (void)setFont:(UIFont *)font{
    _font = font;
    
    self.titleLabel.font = font;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}
- (void)setIsSelected:(BOOL)isSelected{
    if (self.connectedBoxes.count>0 && _isSelected) {
        return;
    }
    
    _isSelected = isSelected;
    self.imageView.highlighted = _isSelected;
    
        for (WGCheckBox *box in self.connectedBoxes) {
            [box updateOtherConnectBoxState:!_isSelected];
        }
    
}

- (void)updateOtherConnectBoxState:(BOOL)select{
    _isSelected = select;
    self.imageView.highlighted = _isSelected;
}



#pragma mark - getter
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_imageView];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.alpha = .8f;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.alpha = 1.f;
    self.isSelected = !_isSelected;
    
    if (_boxTouchesEnd) {
        _boxTouchesEnd(self);
    }
}

@end

