//
//  WGPopoverView.h
//  MyCustomTableViewForSelected
//
//  Created by Apple on 13-7-4.
//  Copyright (c) 2013年 zhu shouyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kTableViewDefaultHeight 44.f
#define kTableView_Title_FontSize 16.f
/**
	弹出框的标题
	@returns NSString *
 */
typedef NSString *(^Title)(void);
/**
	是否使用默认弹出界面
	@returns YES/NO
 */
typedef BOOL (^UserDefinedInterface)(void);
/**
	弹出框所加载的视图view
	@returns UIView* 将要显示的view
 */
typedef UIView *(^LoadingView)(void);

@interface WGPopoverView : UIView/**< 弹出窗显示的内容自定义view时使用 */
- (id)initWithFrame:(CGRect)frame
              title:(Title )titleBlock
userDefinedInterface:(UserDefinedInterface )userDefinedBlack
        loadingView:(LoadingView )loadBlock;
- (void)show;
- (void)dismiss;
@end

@protocol WGPopoverTableViewDelegate;

@interface WGPopoverTableView : WGPopoverView<UITableViewDataSource, /**< 弹出窗显示的内容为列表时使用 */
	UITableViewDelegate> /**< UITableViewDelegate>  */
@property (nonatomic,assign) id<WGPopoverTableViewDelegate> popoverDelegate;
@property (nonatomic,strong) NSArray *datas;
@end

@protocol WGPopoverTableViewDelegate <NSObject>
@required
- (void)wgtableView:(NSString *)tableViewCellText didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (void)wgtableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat )wgtableView:(WGPopoverTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WGPopoverButton : UIControl<WGPopoverTableViewDelegate>
@property (nonatomic,strong) WGPopoverView *popoverView;
@property (nonatomic,copy) NSString *title;
@property (assign) int fontSize;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,assign) NSInteger selectedIndex;

- (void)popTouchEnded;
/**
	button设置左右image及中间的text
	@param image1 UIImage 可为nil
	@param image2 UIImage 可为nil
	@param title UILabel  不可为nil
 */
- (void)setLeftImage:(UIImage *)image1 RightImage:(UIImage *)image2 Title:(NSString *)title;
@end


