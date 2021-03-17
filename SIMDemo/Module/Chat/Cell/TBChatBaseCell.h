//
//  TBChatBaseCell.h
//  SIMDemo
//
//  Created by xiaobing on 2020/11/2.
//

#import <UIKit/UIKit.h>
#import "TBChatMsgManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum TBChatGestureType: NSUInteger {
    TBChatGestureTap = 0,
    TBChatGestureLongPress,
    TBChatGestureTwice,
} TBChatGestureType;

typedef void (^chatCellGesture)(UIGestureRecognizer *,TBChatGestureType);

@interface TBChatBaseCell : UITableViewCell

@property(nonatomic, strong)UIView *messageView;// 主view 承载所有消息显示 和 事件处理
@property(nonatomic, copy)chatCellGesture cellGesture; // 所有事件回调

// 子类Cell 都必须调用此方法重新配置 并且在子类配置数据结束
- (void)configHeaderImg:(SIMSession *)session chatMessage:(SIMMessage *)message;

@end

NS_ASSUME_NONNULL_END
