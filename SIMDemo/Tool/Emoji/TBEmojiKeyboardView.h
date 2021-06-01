//
//  TBEmojiKeyboardView.h
//  SIMDemo
//
//  on 2020/11/4.
//

#import <UIKit/UIKit.h>
#import "TBCustomEmojiModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TBEmojiKeyboardConfig : NSObject

@property(nonatomic) int type; // Emoji类型
@property(nonatomic) float width; // 宽度
@property(nonatomic) float height; // 高度
@property(nonatomic) int count; // 总数目
@property(nonatomic) float marginLeft; // 左边距
@property(nonatomic) float marginTop; // 上边距
@property(nonatomic) float marginHSpace; // 行间距
@property(nonatomic) float marginVSpace; // 列间距
@property(nonatomic) int VMax; // 最大列数目
@property(nonatomic) BOOL canDelete; // 是否可以删除（有删除按钮）
@property(nonatomic) float scaleForBtn; // 相对按钮的缩放比例

@end

@interface TBEmojiKeyboardView : UIView

/**
 发送Block
 */
@property(nonatomic, copy) void (^sendBlock)(void);
/**
 插入Emoji表情的回调
 */
@property(nonatomic, copy) void (^insertEmojiBlock)(NSString *emojiTag);

/**
 删除回调
 */
@property(nonatomic, copy) void (^deleteBackwardBlock)(void);

/// 发送自定义表情
@property(nonatomic, copy) void (^sendCustomEmojiBlock)(TBCustomEmojiModel * emojiModel);
@end

NS_ASSUME_NONNULL_END
