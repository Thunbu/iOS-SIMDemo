//
//  NSString+Addtions.m
//  Geely
//
//  Created by yangfan on 2017/6/25.
//  Copyright © 2017年 Geely. All rights reserved.
//

#import "NSString+Addtions.h"

@implementation NSString (Addtions)


- (CGFloat)getTextHeightWithFont:(UIFont *)font width:(CGFloat)width {
    CGFloat textHeight = 0;

    if (self.length) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dic setObject:font forKey:NSFontAttributeName];

        CGSize size =
            [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil]
                .size;
        textHeight = size.height;
    }

    return textHeight;
}

- (CGFloat)getTextWidthWithFont:(UIFont *)font height:(CGFloat)height {
    CGFloat textWidth = 0;

    if (self.length) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dic setObject:font forKey:NSFontAttributeName];

        CGSize size =
            [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil]
                .size;
        textWidth = size.width;
    }

    return textWidth;
}

@end
