//
//  WGControl.m
//  WebViewUserOutCSS
//
//  Created by Apple on 14-1-26.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "WGControl.h"

@implementation WGControl

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchBegan) {
        _touchBegan(touches,event);
    }
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchMoving) {
        _touchMoving(touches,event);
    }

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchEnd) {
        _touchEnd(touches,event);
    }

}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_touchCancel) {
        _touchCancel(touches,event);
    }
}

@end
