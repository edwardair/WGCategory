//
//  WGControl.h
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchBegan)(NSSet *touches,UIEvent *event);
typedef void (^TouchMoving)(NSSet *touches,UIEvent *event);
typedef void (^TouchEnd)(NSSet *touches,UIEvent *event);
typedef void (^TouchCancel)(NSSet *touches,UIEvent *event);

@interface WGControl : UIControl
@property (nonatomic,strong) TouchBegan touchBegan;
@property (nonatomic,strong) TouchMoving touchMoving;
@property (nonatomic,strong) TouchEnd touchEnd;
@property (nonatomic,strong) TouchCancel touchCancel;

@end
