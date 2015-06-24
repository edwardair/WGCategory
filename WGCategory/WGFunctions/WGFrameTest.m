//
//  WGFrameTest.m
//  WGCategory
//
//  Created by Apple on 13-12-31.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "WGDefines.h"

typedef NS_ENUM(NSInteger, TouchMovingState){
    kState_Start,//开始值
    kState_MovingOnly,//纯平移 无任何检测
    kState_Moving,//可平移状态，同时touchEnd中有检测
    kState_FitFrame,//自身适配frame修改状态，同时touchMoving中有检测
    kState_End,//结束值，start和end限定循环范围
};

static WGFrameTest *test = nil;
@interface WGFrameTest()<UIActionSheetDelegate>{
    UILabel *checkedViewDes;//中心点检测到view时的label显示
    UILabel *touchStateMsg;//touchState状态label指示
}
@property (nonatomic,weak) UIViewController *parentViewController;//父类viewController
@property (nonatomic,weak) UIView *checkedView;//检测到的view
@property (nonatomic) TouchMovingState touchState;
@property (nonatomic) int frameChangingWidthOrHeight;//当width、height改变时，先确定单个方向上的改变，直到下次点击重新确定,0:暂不修改，直到累计增量后确定一个方向；1:纯修改width；2：纯修改height；
@end
@implementation WGFrameTest
+ (WGFrameTest *)shareFrameTest{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[WGFrameTest alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
    });
    return test;
}

+ (void)shareFrameTestWithViewController:(UIViewController *)vc{
    
    WGFrameTest *test_ = [self shareFrameTest];
    
    if (test_.superview) {
        if ([test_.superview isEqual:vc.view]) return;
        else [test_ removeFromSuperview];
    }
    
    [vc.view addSubview:test_];

    test_.parentViewController = vc;
        
}

+ (void)bringTestViewToFront{
    [test.parentViewController.view bringSubviewToFront:test];
}

- (void)setTouchState:(TouchMovingState)touchState{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        touchStateMsg = [[UILabel alloc]init];
        [self addSubview:touchStateMsg];
        touchStateMsg.textColor = [UIColor blueColor];
        touchStateMsg.backgroundColor = [UIColor yellowColor];
        touchStateMsg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    });
    
    _touchState = touchState;
    
    switch (_touchState) {
        case kState_MovingOnly:
            touchStateMsg.text = @"纯移动";
            break;
            case kState_Moving:
            touchStateMsg.text = @"移动+检测中心点";
            break;
        case kState_FitFrame:{
            NSString *changingWidthOrHeight = @"未确定方向";
            if (_frameChangingWidthOrHeight==1) {
                changingWidthOrHeight = @"修改宽";
            }else if (_frameChangingWidthOrHeight==2){
                changingWidthOrHeight = @"修改高";
            }
            touchStateMsg.text = [NSString stringWithFormat:@"修改frame+%@",changingWidthOrHeight];
        }
            break;
        default:
            break;
    }
    [touchStateMsg sizeToFit];
    touchStateMsg.center = ccp(CGRectGetWidth(self.bounds)/2, -CGRectGetHeight(touchStateMsg.frame)/2);
}
#pragma mark getter frame可修改模式 设定修改宽或高
- (void)setFrameChangingWidthOrHeight:(int)frameChangingWidthOrHeight{
    _frameChangingWidthOrHeight = frameChangingWidthOrHeight;
    self.touchState = _touchState;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.alpha = .8f;
        self.touchState = kState_MovingOnly;
        _frameChangingWidthOrHeight = 0;
        
        //self上显示中心点适配到的subView的description，方便测试调试
        checkedViewDes = [[UILabel alloc]initWithFrame:CGRectMake(0, self.wg_height, self.wg_width, 30)];
        [self addSubview:checkedViewDes];
        checkedViewDes.font = [UIFont systemFontOfSize:16.f];
        checkedViewDes.numberOfLines = 0;
        checkedViewDes.textColor = [UIColor blueColor];
        checkedViewDes.backgroundColor = [UIColor yellowColor];
        checkedViewDes.center = ccp(self.wg_width/2, checkedViewDes.center.y);
        checkedViewDes.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        checkedViewDes.adjustsFontSizeToFitWidth = YES;
        //添加中心点
        UIView *middleDot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        [self addSubview:middleDot];
        middleDot.backgroundColor = [UIColor yellowColor];
        middleDot.center = ccpMidpoint(self.bounds.origin, ccp(self.wg_right-self.wg_left, self.wg_bottom-self.wg_top));
        middleDot.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin;
        
        //添加双击手势，更改state状态
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoTaps)];
        [self addGestureRecognizer:tapGesture];
        tapGesture.numberOfTapsRequired = 2;//需要双击触发方法
        
        //self监听self。frame修改
        [self addObserver:self forKeyPath:@"frame" options:0 context:NULL];
        [self addObserver:self forKeyPath:@"center" options:0 context:NULL];
    }
    return self;
}

#pragma mark tapGesture 双击触发方法
- (void)twoTaps{
    _touchState +=1;
    if (_touchState>=kState_End) {
        _touchState = kState_Start+1;
    }
    self.touchState = _touchState;
}

#pragma mark KVO 监听frame
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        NSString *checkedViewDescription = @"未检测到view";//_checkedView?_checkedView.description:;
        if (_touchState==kState_Moving) {
            checkedViewDescription = _checkedView?[NSString stringWithFormat:@"%@:%@",NSStringFromClass([_checkedView class]),WGOBJC(_checkedView.frame)]:checkedViewDescription;
        }
        else if (_touchState==kState_FitFrame){
            CGRect checkedViewWillUseFrame = [_checkedView.superview convertRect:self.frame fromView:self.superview];
            checkedViewDescription = [NSString stringWithFormat:@"%@：将使用的绝对frame:%@",NSStringFromClass(_checkedView.class),WGOBJC(checkedViewWillUseFrame)];
        }
        checkedViewDes.text = [NSString stringWithFormat:@"%@",checkedViewDescription];
        WGLogValue(checkedViewDes.text);
        checkedViewDes.wg_width = self.wg_width;
    }else if ([keyPath isEqualToString:@"center"] && _touchState==kState_MovingOnly){
        NSString *checkedViewDescription = @"未检测到view";//_checkedView?_checkedView.description:;
        checkedViewDescription = _checkedView?[NSString stringWithFormat:@"%@:%@",NSStringFromClass([_checkedView class]),WGOBJC([self.superview convertRect:self.frame toView:_checkedView.superview])]:checkedViewDescription;

        checkedViewDes.text = checkedViewDescription;
        WGLogValue(checkedViewDes.text);

    }
}

#pragma mark 中心点所在视图检测
- (UIView *)checkBoundsInView:(UIView *)parent CheckSubViewLevel:(NSInteger )lv{
    NSEnumerator *myReverse = [parent.subviews reverseObjectEnumerator];
    UIView *sub = nil;
    while (sub=[myReverse nextObject]) {
//        WGLOG(WGConstantStringToString(sub));
        //排除 self
        if ([sub isEqual:self]) {
            continue;
        }else{
            CGPoint curViewCenter = [self.superview convertPoint:self.center toView:sub.superview];
//            WGLOG(WGPointToString(self.center));
            //如果在区间中，递归检测其子view是否满足条件
            if (CGRectContainsPoint(sub.frame, curViewCenter)) {
                if (lv>0) {
                    UIView *didMeetSub_SubView = [self checkBoundsInView:sub CheckSubViewLevel:--lv];
                    //如果不满足  则确认为选中当前sub
                    if (!didMeetSub_SubView) return sub;
                    else return didMeetSub_SubView;
                }
                else{
                    return sub;
                }
            }
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    _isTouchesBegan = YES;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:_parentViewController.view];
    CGPoint preLocation = [touch previousLocationInView:_parentViewController.view];
    
    if (_touchState==kState_Moving) {//当前状态如果为kState_Moving，并且移动时，修改状态为kState_MovingOnly
        self.touchState = kState_MovingOnly;
    }
   else if (_touchState== kState_MovingOnly) {
        self.center = ccpAdd(self.center, ccpSub(touchLocation, preLocation));
    }
    else if (_touchState==kState_FitFrame){
        static float zoomRate = .5f;//缩放比率，当修改frame时，需要精调，故将修改比率缩小
        CGPoint detlaPoint = ccpMult(ccpSub(touchLocation, preLocation), zoomRate);
        
        //如果还未确认修改宽或高，当某一方向的偏量大于另一方向的偏量10个像素，确认方向
        if (_frameChangingWidthOrHeight==0) {
            static CGPoint increate;
            increate = ccpAdd(increate, detlaPoint);
            if ( fabs(increate.x) > (fabs(increate.y)+10) ) {
                self.frameChangingWidthOrHeight = 1;
                //确定后 清零
                increate = CGPointZero;
            }else if ( fabs(increate.y) > (fabs(increate.x)+10) ){
                self.frameChangingWidthOrHeight = 2;
                //确定后 清零
                increate = CGPointZero;
            }
        }else{//以确定宽或高 修改
            if (_frameChangingWidthOrHeight==1) {
                self.wg_width += detlaPoint.x;
            }
            else if(_frameChangingWidthOrHeight==2){
                self.wg_height += detlaPoint.y;
            }
        }
        
    }
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{    
    _isTouchesBegan = NO;

    //当处于移动过程中时，才检测中心点
    if (_touchState==kState_Moving) {
        
        //弹出表单 提示check父类 还是递归进子类
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"查询子类层级" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20", nil];
        [sheet showInView:KeyWindow];
        
    }else if (_touchState==kState_FitFrame){
        //当为修改frame状态时，touchEnd时，置frameChangingWidthOrHeight为0
        self.frameChangingWidthOrHeight = 0;
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger lv = buttonIndex;
    if (lv==21) {//21为 取消 按钮
        return;
    }
    //遍历检测  self中心点处于那个subView中
    UIView *meetView = [self checkBoundsInView:_parentViewController.view CheckSubViewLevel:lv];
    //查找到满足条件的view之后，修改self的显示
    if (meetView) {
        _checkedView = meetView;
        CGRect meetViewWorldFrame = [meetView.superview convertRect:meetView.frame toView:_parentViewController.view];
        self.frame = meetViewWorldFrame;
    }

}

#pragma mark UIGesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return NO;
}

@end
