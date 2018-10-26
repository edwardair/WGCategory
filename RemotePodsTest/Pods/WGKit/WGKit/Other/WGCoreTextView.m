//
//  CoreTextView.m
//  CoreText
//
//  Created by Apple on 13-9-5.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "WGCoreTextView.h"
#import "WGDefines.h"
@interface WGCoreTextView(){
    CTFramesetterRef _framesetter;
}
@end
@implementation WGCoreTextView
+ (WGCoreTextView_Height_CTFramsetter )estimateHeightWithText:(NSString *)text
                                                       Ranges:(NSArray *)ranges
                                                        Fonts:(NSDictionary *)fonts
                                                       Colors:(NSDictionary *)colors
                                                   frameWidth:(CGFloat )width{
    WGCoreTextView_Height_CTFramsetter core;
    core.framesetter = NULL;
    core.height = 0.0f;
    
    if (!text || !text.length) {
        return core;
    }
    
    CTFramesetterRef framesetter = NULL;
        
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc]
                                            initWithString:text];
    
    //遍历  _ranges 数组，按照NSRange划定的范围给text添加相应属性
    for (NSValue *obj in ranges) {
        NSRange range = [obj rangeValue];
        NSNumber *font_NSNumber = fonts[Key_NSRange((unsigned long)range)];
        CGFloat fontSize = font_NSNumber.floatValue;
        if (!font_NSNumber) {//font_NSNumber不存在时，使用默认字体大小
            fontSize = CoreTextView_DefaultFontSize;
        }
        UIFont *font = SystemFont(fontSize);
        UIColor *color = colors[Key_NSRange((unsigned long)range)];
        if (!color) {//color不存在使用默认颜色
            color = CoreTextView_DefaultColor;
        }
        CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef )font.fontName, fontSize, NULL);
        CGColorRef colorRef = color.CGColor;
        id key_font = (id )kCTFontAttributeName;
        id key_color = (id )kCTForegroundColorAttributeName;
        
        //attString先删除range范围内的属性
        [attString removeAttribute:key_font range:range];
        [attString removeAttribute:key_color range:range];
        
        //attString增加属性
        [attString addAttribute:key_font value:(__bridge id )fontRef range:range];
        [attString addAttribute:key_color value:(__bridge id )colorRef range:range];
        
        //带Create的都要手动释放释放
        CFRelease(fontRef);
        
    }
    
    //创建文本对齐方式
    CTTextAlignment alignment = kCTTextAlignmentNatural;//这种对齐方式会自动调整，使左右始终对齐
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
    alignmentStyle.valueSize=sizeof(alignment);
    alignmentStyle.value=&alignment;
    
    //创建样式数组
    CTParagraphStyleSetting settings[]={
        alignmentStyle
    };
    //设置样式
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings));
    
    [attString removeAttribute:(id )kCTParagraphStyleAttributeName range:NSMakeRange(0, [attString length])];
    [attString addAttribute:(id )kCTParagraphStyleAttributeName value:(__bridge id )paragraphStyle range:NSMakeRange(0, [attString length])];
    
    CFRelease(paragraphStyle);
    
    //不懂
    framesetter =
    CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    
    //tempSize.height 为绘制的textView的高度
    CGSize tmpSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), NULL, CGSizeMake(width , INT32_MAX), NULL);

    core.framesetter = framesetter;
    core.height = tmpSize.height;
    
    return core;
}
- (id)initWithFrame:(CGRect)frame
{
    //将frame。size.height修改为0，禁止drawRect的调用
    frame.size.height = 0.0f;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _text = @"";
        _ranges = [NSMutableArray array];
        _fontes = [NSMutableDictionary dictionary];
        _colors = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
//    [self clearBGColor];
    [self draw];
}
//- (void)layoutSubviews
//{
//	[self setNeedsDisplay];
//}
#pragma mark 获取 text计算出的高度，同时，创建CTFramsetterRef 要正常显示 必须调用此方法
- (void )update{
    if (_framesetter) {
        CFRelease(_framesetter);
        _framesetter = NULL;
    }

    WGCoreTextView_Height_CTFramsetter core = [WGCoreTextView estimateHeightWithText:_text
                                                                               Ranges:_ranges
                                                                                Fonts:_fontes
                                                                               Colors:_colors
                                                                           frameWidth:CGRectGetWidth(self.frame)];
    _framesetter = core.framesetter;
    _height_CTFramsetter = core;
    self.wg_height = core.height;
    [self setNeedsDisplay];
    
}
- (void )draw{
    if (!_text.length && !_framesetter) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //清除context
    CGContextClearRect(context, self.bounds);

    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds );

    CTFrameRef frame =
    CTFramesetterCreateFrame(_framesetter,
                             CFRangeMake(0, [_text length]), path, NULL);
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(path);
}
@end
