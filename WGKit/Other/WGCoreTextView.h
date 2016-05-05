//
//  CoreTextView.h
//  CoreText
//
//  Created by Apple on 13-9-5.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

typedef struct WGCoreTextView_Height_CTFramsetter{
    CTFramesetterRef framesetter;
    CGFloat height;
}WGCoreTextView_Height_CTFramsetter;
/**
 *	@brief NSRange的对象封装
 *
 *	@param 	range 	NSRange
 *
 *	@return	NSValue
 */
#define NSValueOfRange(range) [NSValue valueWithRange:range]
/**
 *	@brief	NSRange  对应的  字典中的 key
 *
 *	@param 	range 	NSRange
 *
 *	@return	NSString
 */
#define Key_NSRange(range) [NSString stringWithFormat:@"%lu-%lu",range.location,range.length]
#define SystemFont(size) [UIFont systemFontOfSize:size]
/**
 *	@brief	默认字体
 */
#define CoreTextView_DefaultFontSize 14.f
/**
 *	@brief	默认字体颜色
 */
#define CoreTextView_DefaultColor [UIColor blackColor]
/**
 *	@brief UILabel UITextView的扩展，更改text属性
 */
@interface WGCoreTextView : UIView
/**
 *	@brief	显示的NSString
 */
@property (nonatomic,copy) NSString *text;
/**
 *	@brief	NSMutableAttributedString 在分段设置属性时参照的NSRange 
*/
@property (nonatomic,strong) NSMutableArray *ranges;
/**
 *	@brief	每个分段的font字典,value为size数据，默认使用系统字体，key为Key_NSRange(range)，默认font为系统字体，14号
 */
@property (nonatomic,strong) NSMutableDictionary *fontes;
/**
 *	@brief	每个分段的color字典，默认为黑色
 */
@property (nonatomic,strong) NSMutableDictionary *colors;
@property (nonatomic,assign)  WGCoreTextView_Height_CTFramsetter height_CTFramsetter;
/**
 *	@brief	需要在参数设置好之后 手动调用此方法，以便获取到计算出来的text高度，更改self.frame
 *
 *	@return	text适配后的高度
 */
- (void )update;
+ (WGCoreTextView_Height_CTFramsetter )estimateHeightWithText:(NSString *)text
                                                       Ranges:(NSArray *)ranges
                                                        Fonts:(NSDictionary *)fonts
                                                       Colors:(NSDictionary *)colors
                                                   frameWidth:(CGFloat )width;

@end

