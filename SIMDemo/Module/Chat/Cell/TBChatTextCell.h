//
//  TBChatTextCell.h
//  SIMDemo
//
//  Created by xiaobing on 2020/11/2.
//

#import <UIKit/UIKit.h>
#import "TBChatBaseCell.h"

@class TBChatMsgManager;

NS_ASSUME_NONNULL_BEGIN

// 文本类消息体
@interface TBChatTextCell : TBChatBaseCell

- (void)configChatTextMessage:(SIMSession *)session chatMessage:(SIMMessage *)message chatManager:(TBChatMsgManager *)manager;
@end

NS_ASSUME_NONNULL_END
