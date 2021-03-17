//
//  UITextView+Rich.h
//  private
//
//  Created by yangfan on 2018/3/9.
//  Copyright © 2018年 aaaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Rich)

/**
 插入一个Emoji表情到输入框中

 @param image Emoji
 @param tag 标记
 @param marge 左右间距，目前代码为对此未做处理
 */
- (void)insertEmoji:(UIImage *)image tag:(NSString *)tag marge:(float)marge;

/**
 插入一个Emoji表情原始文本到输入框中
 @param text Emoji
 */
- (void)TB_insertText:(NSString *)text;

/**
 返回纯文本化的富文本
 */
- (NSString *)staticEmojiText;

@end
