//
//  NSMutableAttributedString+WGString.m
//  Pods
//
//  Created by RayMi on 2020/4/13.
//

#import "NSMutableAttributedString+WGString.h"

@implementation NSMutableAttributedString (WGString)
+ (instancetype)add:(NSString *)text {
    return [self add:text font:nil];
}
+ (instancetype)add:(NSString *)text font:(UIFont *)font {
    return [self add:text font:font color:nil];
}
+ (instancetype)add:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    return [self add:text font:font color:color extra:nil];
}
+ (instancetype)add:(NSString *)text font:(UIFont *)font color:(UIColor *)color extra:(NSDictionary<NSAttributedStringKey,id> *)extra {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
    [attr add:text font:font color:color extra:extra];
    return attr;
}

#pragma mark -
- (instancetype)add:(NSString *)text {
    return [self add:text font:nil];
}
- (instancetype)add:(NSString *)text font:(UIFont *)font {
    return [self add:text font:font color:nil];
}
- (instancetype)add:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    return [self add:text font:font color:color extra:nil];
}
- (instancetype)add:(NSString *)text font:(UIFont *)font color:(UIColor *)color extra:(NSDictionary<NSAttributedStringKey,id> *)extra {
    NSMutableDictionary<NSAttributedStringKey,id> *attributes = @[].mutableCopy;
    if (font) {
        [attributes setObject:font forKey:NSFontAttributeName];
    }
    if (color) {
        [attributes setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (extra) {
        [attributes addEntriesFromDictionary:extra];
    }
    NSAttributedString *sub = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    [self appendAttributedString:sub];
    return self;
}
- (instancetype)addAttributed:(NSRange )inRange font:(UIFont *)font color:(UIColor *)color extra:(NSDictionary<NSAttributedStringKey,id> *)extra {
    NSMutableDictionary<NSAttributedStringKey,id> *attributes = @[].mutableCopy;
    if (font) {
        [attributes setObject:font forKey:NSFontAttributeName];
    }
    if (color) {
        [attributes setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (extra) {
        [attributes addEntriesFromDictionary:extra];
    }
    [self addAttributes:attributes range:inRange];
    return self;
}
@end
