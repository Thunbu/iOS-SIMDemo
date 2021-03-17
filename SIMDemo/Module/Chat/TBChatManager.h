//
//  TBChatManager.h
//  SIMDemo
//
//  Created by changxuanren on 2020/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TBIMChatMessageDelegate <NSObject>
@optional
- (void)messageDidReceived:(SIMMessage *)message;
- (void)messageDidDeleted:(SIMMessage *)message;
@end

@interface TBChatManager : NSObject

+ (instancetype)sharedInstanced;

// 保存当前userId 用于判断消息是否是自己发的 SIMMessage.sender
- (void)remberCurrentUser:(NSString *)userId;
- (NSString *)currentUserId;

//设置代理（由于每个会话窗口都可能需要注册，所以需要注册和取消注册同时维护）
- (void)registerDelegate:(id<TBIMChatMessageDelegate>)delegate;

//移除代理
- (void)unRegisterDelegate:(id<TBIMChatMessageDelegate>)delegate;

//接收到消息
- (void)receiveMessage:(SIMMessage *)msg;

//删除消息
- (void)deleteMessage:(SIMMessage *)msg completion:(void(^)(SIMMessage *msg, SIMError *error))completion;

/// 拉取会话历史消息
/// @param sessionId 会话ID
/// @param msgId 起始消息ID，第一页传nil
/// @param completion 回调
- (void)pullHistoryMsgsOfSession:(NSString *)sessionId fromMsgId:(nullable NSString *)msgId completion:(void(^)(NSArray<SIMMessage *> *msgs, SIMError *error))completion;

//发送文本消息
- (void)sendTextMessageTo:(NSString *)to text:(NSString *)text atArray:(NSArray *)atArray completion:(void(^)(SIMMessage *, SIMError *error))completion;

//发送图片消息（注意：发送图片和视频消息，宽高和大小等参数需要业务方传递真实值，以保证消息的可靠性）
- (void)sendImageMessageTo:(NSString *)to url:(NSString *)url isHD:(BOOL)isHD completion:(void(^)(SIMMessage *, SIMError *error))completion;

//发送视频消息
- (void)sendVideoMessageTo:(NSString *)to url:(NSString *)url coverUrl:(NSString *)coverUrl completion:(void(^)(SIMMessage *, SIMError *error))completion;

@end

NS_ASSUME_NONNULL_END
