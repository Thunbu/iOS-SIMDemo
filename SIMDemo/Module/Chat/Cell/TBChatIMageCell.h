//
//  TBChatIMageCell.h
//  SIMDemo
//
//  on 2020/11/4.
//

#import <UIKit/UIKit.h>
#import "TBChatBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TBChatIMageCell : TBChatBaseCell

- (void)configChatImageMessage:(SIMSession *)session chatMessage:(SIMMessage *)message chatManager:(TBChatMsgManager *)manager;
@end

NS_ASSUME_NONNULL_END
