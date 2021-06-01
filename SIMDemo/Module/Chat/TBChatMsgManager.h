//
//  TBChatManager.h
//  SIMDemo
//
//  on 2020/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBChatMsgManager : NSObject


// 获取要显示的消息高度
- (CGFloat)messageBodyHeight:(SIMMessage *)message;
- (CGFloat)messageBodyWidth:(SIMMessage *)message;

@end

NS_ASSUME_NONNULL_END
