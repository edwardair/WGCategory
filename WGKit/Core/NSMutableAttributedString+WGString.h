//
//  NSMutableAttributedString+WGString.h
//  Pods
//
//  Created by RayMi on 2020/4/13.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (WGString)
+ (instancetype)add:(NSString *)text;
+ (instancetype)add:(NSString *)text font:(UIFont *)font;
+ (instancetype)add:(NSString *)text font:(UIFont *)font color:(UIColor *)color;
+ (instancetype)add:(NSString *)text font:(UIFont *)font color:(UIColor *)color extra:(NSDictionary<NSAttributedStringKey,id> *)extra;
- (instancetype)add:(NSString *)text;
- (instancetype)add:(NSString *)text font:(UIFont *)font;
- (instancetype)add:(NSString *)text font:(UIFont *)font color:(UIColor *)color;
- (instancetype)add:(NSString *)text font:(UIFont *)font color:(UIColor *)color extra:(NSDictionary<NSAttributedStringKey,id> *)extra;
- (instancetype)addAttributed:(NSRange )inRange font:(UIFont *)font color:(UIColor *)color extra:(NSDictionary<NSAttributedStringKey,id> *)extra;
@end
