//
//  UIColor+TB.h
//  SIMDemo
//
//  on 2020/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TB)

+ (UIColor *)TB_colorForHex:(long)hexColor;

+ (UIColor *)TB_colorForHex:(long)hexColor Alpha:(CGFloat)alpha;

+ (UIColor *)TB_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue Alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
