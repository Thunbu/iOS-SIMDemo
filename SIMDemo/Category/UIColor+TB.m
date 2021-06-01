//
//  UIColor+TB.m
//  SIMDemo
//
//  on 2020/10/28.
//

#import "UIColor+TB.h"

@implementation UIColor (TB)

+ (UIColor *)TB_colorForHex:(long)hexColor {
    return [UIColor TB_colorForHex:hexColor Alpha:1.0f];
}

+ (UIColor *)TB_colorForHex:(long)hexColor Alpha:(CGFloat)alpha {
    float r = ((float) ((hexColor & 0xFF0000) >> 16)) / 255.0;
    float g = ((float) ((hexColor & 0xFF00) >> 8)) / 255.0;
    float b = ((float) (hexColor & 0xFF)) / 255.0;

    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

+ (UIColor *)TB_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue Alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(float) (red / 255.f) green:(float) (green / 255.f) blue:(float) (blue / 255.f) alpha:alpha];
}

@end
