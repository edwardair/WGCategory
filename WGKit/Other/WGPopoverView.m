//
//  WGPopoverView.m
//  MyCustomTableViewForSelected
//
//  Created by Apple on 13-7-4.
//  Copyright (c) 2013年 zhu shouyu. All rights reserved.
//

#import "WGPopoverView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIDevice+WGCategory.h"

#define TitleHeight 30

@interface WGPopoverView()
@property (nonatomic,strong) NSString *headerTitle;
@property (nonatomic,strong) UIControl *emptyTouched;
@end
@implementation WGPopoverView

- (id)initWithFrame:(CGRect)frame
              title:(Title )titleBlock
userDefinedInterface:(UserDefinedInterface )userDefinedBlack
         loadingView:(LoadingView )loadBlock
{
    //标题存在的情况下，frame需要相应修改
    if (titleBlock) {
        frame.origin.y -= TitleHeight/2;
        frame.size.height += TitleHeight;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.alpha = 0;
        
        //如果返回的是NO，则设置self。layer属性为默认属性
        if (!userDefinedBlack()) {
            [self defaultUserInterface];
        }
        if (titleBlock) {
            _headerTitle = titleBlock();
            
        }
        UIView *wilLoadView = loadBlock();
        if (wilLoadView) {
            [self addSubview:wilLoadView];
        }
    }
    return self;
}
- (void)defaultUserInterface{
    self.layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7].CGColor;
    self.layer.cornerRadius = 0;
    self.layer.masksToBounds = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)show{
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    _emptyTouched = [[UIControl alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [keyWindow addSubview:_emptyTouched];
    [_emptyTouched addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchDown];
    [_emptyTouched setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.7]];
    
    [keyWindow addSubview:self];
    
    [self animatedIn];
    
}
- (void)dismiss{
    [self animatedOut];
}
- (void)animatedIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    _emptyTouched.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self->_emptyTouched.alpha = .5f;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)animatedOut
{
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
        self->_emptyTouched.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self->_emptyTouched)
            {
                [self->_emptyTouched removeFromSuperview];
            }
            [self removeFromSuperview];
        }
    }];

}

@end


#pragma mark WGPopoverTableView
@interface WGPopoverTableView()
@property (nonatomic,strong) UITableView *loadTableView;
@end
@implementation WGPopoverTableView
- (id )initWithFrame:(CGRect)frame
    title:(Title)titleBlock userDefinedInterface:(UserDefinedInterface)userDefinedBlack loadingView:(LoadingView)loadBlock{
    self = [super initWithFrame:frame
                          title:titleBlock
           userDefinedInterface:userDefinedBlack
                    loadingView:loadBlock];
    if (self) {
        _loadTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_loadTableView];
        _loadTableView.layer.backgroundColor = self.layer.backgroundColor;
        _loadTableView.layer.cornerRadius = self.layer.cornerRadius;
        _loadTableView.backgroundColor = [UIColor clearColor];
        _loadTableView.delegate = self;
        _loadTableView.dataSource = self;
        if ([UIDevice isIOS7Version]) {
            _loadTableView.separatorInset = UIEdgeInsetsZero;
        }
    }
    return self;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.headerTitle?TitleHeight:0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = nil;
    if (self.headerTitle) {
        header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, TitleHeight)];
        UILabel *label = [[UILabel alloc]initWithFrame:header.frame];
        [header addSubview:label];
        label.text = self.headerTitle;
        label.textAlignment = 1;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        header.backgroundColor = [UIColor blackColor];
    }
    return header;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kTableViewDefaultHeight;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_popoverDelegate && [_popoverDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [_popoverDelegate wgtableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_popoverDelegate wgtableView:_datas[indexPath.row] didSelectRowAtIndexPath:indexPath];
    [self dismiss];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static  NSString *identify = @"WGPopoverTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8].CGColor;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.alpha = .5f;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:kTableView_Title_FontSize];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_datas[indexPath.row]];
    cell.textLabel.textAlignment = 1;
    return cell;
}

@end


@interface WGPopoverButton()
@property (nonatomic,strong) UIImage *leftImage;
@end
@implementation WGPopoverButton
- (id )initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _selectedIndex = 0;
        _fontSize=0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    }
return self;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = [NSString stringWithFormat:@"%@",title];
    [_titleLabel sizeToFit];
    CGSize size = self.frame.size;
    if (_leftImage) {
        _titleLabel.frame = CGRectMake(_leftImage.size.width + 5, (size.height-_titleLabel.frame.size.height)/2, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
    }else{
        _titleLabel.frame = CGRectMake(5, (size.height-_titleLabel.frame.size.height)/2, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
    }

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.alpha = .9f;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.alpha = 1.f;
    [self.popoverView show];
}
- (void)popTouchEnded{
    [self.popoverView dismiss];
}
#pragma mark 通用 popoverButton设置
- (void)setLeftImage:(UIImage *)image1 RightImage:(UIImage *)image2 Title:(NSString *)title{
    _leftImage = image1;

    UILabel *label = [[UILabel alloc]init];
    [self addSubview:label];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:_fontSize==0?kTableView_Title_FontSize:_fontSize];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    _titleLabel = label;
    
    CGSize size = self.frame.size;
    UIImageView *left,*right;
    if (image1) {
        left = [[UIImageView alloc]initWithImage:image1];
        [self addSubview:left];
        left.frame = CGRectMake(0, (size.height-image1.size.height)/2, image1.size.width, image1.size.height);
    }
    
    self.title = title;
    
    if (image2) {
        right = [[UIImageView alloc]initWithImage:image2];
        [self addSubview:right];
        right.frame = CGRectMake(size.width-image2.size.width, (size.height-image2.size.height)/2, image2.size.width, image2.size.height);
        right.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    }
}
#pragma mark WGPopoverTableDelegate
- (void)wgtableView:(NSString *)tableViewCellText didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.title = tableViewCellText;
    self.selectedIndex = indexPath.row;
}
@end


