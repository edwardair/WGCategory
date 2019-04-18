//
//  WGActionSheet.h
//  OneRed
//
//  Created by MBP on 14-7-30.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80300

@class WGActionSheet;
typedef void (^ ActionSheetClickedAtIndex)(NSInteger buttonIndex,WGActionSheet *sheet_);

#define ShowActionSheetInView(view, title, cancelTitle,                 \
destructiveTitle, ...)                           \
({                                                                           \
WGActionSheet *sheet_ =                                                    \
[[WGActionSheet alloc] initWithTitle:title                             \
delegate:nil                               \
cancelButtonTitle:cancelTitle                       \
destructiveButtonTitle:destructiveTitle                  \
otherButtonTitles:__VA_ARGS__];                     \
[sheet_ showInView:view];                                                  \
sheet_;                                                                    \
})


@interface WGActionSheet : UIActionSheet<UIActionSheetDelegate>
@property (nonatomic,copy) ActionSheetClickedAtIndex block;

@end

#endif
