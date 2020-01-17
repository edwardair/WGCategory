//
//  WGActionSheet.m
//  OneRed
//
//  Created by MBP on 14-7-30.
//  Copyright (c) 2014å¹´ abc. All rights reserved.
//

#import "WGActionSheet.h"
#import "WGLog.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80300


@implementation WGActionSheet

#pragma mark - setter
- (void)setBlock:(ActionSheetClickedAtIndex)block{
    _block = block;
    
    self.delegate = self;
    
}
#pragma mark UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    WGLogFormatValue(@"%ld",(long)buttonIndex);
    if (_block) {
        _block(buttonIndex,self);
    }
}
@end

#endif
