//
//  NSString+Rich.m
//  private
//
//  Created by yangfan on 2018/3/9.
//  Copyright © 2018年 aaaa. All rights reserved.
//

#import "TBEmojiHelp.h"
#import "NSString+Rich.h"
#import "RichTextAttachment.h"
#import <YYText/YYText.h>

@implementation NSString (Rich)

- (NSMutableAttributedString *)TB_richTextForYYTextWithFont:(UIFont *)font {
    NSMutableAttributedString *richAttributedText = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSString *pattern = @"\\[\\w{1,20}\\]";
    NSError *error;
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    for (int i = result.count - 1; i >= 0; i--) {
        NSTextCheckingResult *res = result[ i ];
        NSString *tag = [self substringWithRange:res.range];
        NSString *emojiName = [tag substringWithRange:NSMakeRange(1, tag.length - 2)];
        UIImage *emoji = [TBEmojiHelp pullImgWithName:emojiName];
        if (!emoji) { // 如果找不到该emoji，则不做处理，预防[语音][图片]等特殊文本
            continue;
        }
        RichTextAttachment *emojiAttach = [RichTextAttachment new];
        emojiAttach.image = emoji;
        emojiAttach.tag = tag;
        
        if (font) { //表情大小根据字体大小的1.75倍显示
            float emojiWidth = (font.pointSize * 1.75) * emoji.size.width / emoji.size.height;
            float emojiHeight = font.pointSize * 1.75;
            emojiAttach.bounds = CGRectMake(0, -font.pointSize / 2.0, emojiWidth, emojiHeight);
        } else { //显示表情原图大小
            emojiAttach.bounds = CGRectMake(0, -font.pointSize / 2.0, emoji.size.width, emoji.size.height);
        }
        NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:emojiAttach];
        [richAttributedText replaceCharactersInRange:res.range withAttributedString:imgStr];
    }
    //设置字体大小
    richAttributedText.yy_font = font;
    //设置行间距
    richAttributedText.yy_lineSpacing = 0.0;

    return richAttributedText;
}



@end
