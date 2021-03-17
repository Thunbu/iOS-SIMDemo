//
//  TBChatVideoCell.h
//  SIMDemo
//
//  Created by xiaobing on 2020/11/5.
//

#import "TBChatBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TBChatVideoCell : TBChatBaseCell

- (void)configChatVideoMessage:(SIMSession *)session chatMessage:(SIMMessage *)message chatManager:(TBChatMsgManager *)manager;

@end

NS_ASSUME_NONNULL_END
