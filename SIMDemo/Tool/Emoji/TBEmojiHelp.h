//
//  GLEmojiHelp.h
//  Geely
//
//  on 2018/3/16.
//

#import <Foundation/Foundation.h>
#import "TBCustomEmojiModel.h"

typedef NS_ENUM(NSInteger, TBEmojiHelpType) {
    TBEmojiHelpTypeWithYelloMan,
    TBEmojiHelpTypeWithGeelyStatic,
    TBEmojiHelpTypeWithGeelyGif,
    TBEmojiHelpTypeWithCustomGif
};

@interface TBEmojiHelp : NSObject


+ (int16_t)pullEmojiCountWithType:(TBEmojiHelpType)type;

//根据索引获取表情图片
+ (UIImage *)pullImgWithIndex:(int16_t)index type:(TBEmojiHelpType)type;
//根据名字获取表情图片
+ (UIImage *)pullImgWithName:(NSString *)name;

//根据索引获取中文名
+ (NSString *)pullChineseNameWithIndex:(int16_t)index type:(TBEmojiHelpType)type;



/// 移除文本最后一个emoji表情文本（最后部分不是表情则删除最后一个字符）
/// @param text 原文本
+ (NSString *)removeLastEmoji:(NSString *)text;

@end
