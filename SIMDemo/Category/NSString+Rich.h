//
//  NSString+Rich.h
//  private
//
//  Created by yangfan on 2018/3/9.
//  Copyright © 2018年 aaaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Rich)


/**
 将本身NSString类型转变为富文本NSMutableAttributedString类型，用于：
 1. 消息列表中使用YYLabel显示，达到异步加载的效果。
 */
- (NSMutableAttributedString *)TB_richTextForYYTextWithFont:(UIFont *)font;


@end
