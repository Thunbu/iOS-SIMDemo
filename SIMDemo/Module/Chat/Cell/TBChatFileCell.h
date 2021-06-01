//
//  TBChatFileCell.h
//  SIMDemo
//
//  on 2021/1/27.
//

#import "TBChatBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TBChatFileCell : TBChatBaseCell

- (void)configChatVideoMessage:(SIMSession *)session chatMessage:(SIMMessage *)message chatManager:(TBChatMsgManager *)manager;
@end

NS_ASSUME_NONNULL_END
