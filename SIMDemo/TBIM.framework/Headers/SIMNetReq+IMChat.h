//
//  NBNetReq+IMChat.h
//  NBIMDemo
//
//  Created by changxuanren on 2019/6/4.
//  Copyright © 2019年 闪布科技. All rights reserved.
//

#import "SIMNetReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMNetReq (IMChat)

/**
 查询离线消息

 @param params 参数
 */
- (NSURLSessionDataTask *)pullMsgList:(NSDictionary *)params
                          complection:(JSONResultBlock)complection;

/// 查询会话消息（包括指令消息）
/// @param params 参数
/// @param complection 回调
- (NSURLSessionDataTask *)pullAllMsgList:(NSDictionary *)params
                             complection:(JSONResultBlock)complection;

/**
 根据消息Id查询消息
 
 @param ids 消息Id列表
 @param sessionType 单聊 0/群聊 1
 */
- (NSURLSessionDataTask *)pullMsgListWithMsgIds:(NSArray *)ids
                                    sessionType:(int16_t)sessionType
                                    complection:(JSONResultBlock)complection;

/**
 根据消息根Id查询回复盖楼消息
 
 @param messageId 根消息Id
 @param sessionType 单聊 0/群聊 1
 */
- (NSURLSessionDataTask *)pullMsgReplyListWithRootMsgId:(NSString *)messageId
                                            sessionType:(int16_t)sessionType
                                            complection:(JSONResultBlock)complection;

/**
 获取标记列表

 @param sessionId 会话ID
 @param sessionType 类型 0单聊，1群聊
 @param securityType 安全类型，0普通，1密聊
 @param signDate 标记时间戳
 @param rows 条数
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)pullSignList:(NSString *)sessionId
                           sessionType:(NSInteger)sessionType
                          securityType:(NSInteger)securityType
                              signDate:(long)signDate
                                  rows:(NSInteger)rows
                           complection:(JSONResultBlock)complection;

/**
 标记消息

 @param msgId 消息ID
 @param sessionId 会话ID
 @param securityType 安全类型，0普通，1密聊
 @param sessionType 类型 0单聊，1群聊
 @param cross NO表示不是外域，YES表示为跨域
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)signMessage:(NSString *)msgId
                            sessionId:(NSString *)sessionId
                         securityType:(NSInteger)securityType
                          sessionType:(NSInteger)sessionType
                                cross:(NSInteger)cross
                          complection:(JSONResultBlock)complection;

/**
 取消标记消息
 
 @param msgId 消息ID
 @param sessionId 会话ID
 @param securityType 安全类型，0普通，1密聊
 @param sessionType 类型 0单聊，1群聊
 @param cross NO表示不是外域，YES表示为跨域
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)unSignMessage:(NSString *)msgId
                              sessionId:(NSString *)sessionId
                           securityType:(NSInteger)securityType
                            sessionType:(NSInteger)sessionType
                                  cross:(NSInteger)cross
                            complection:(JSONResultBlock)complection;

/**
 根据消息根Id拉取消息
 
 @param messageId 根消息Id
 @param sessionType 单聊 0/群聊 1
 */
- (NSURLSessionDataTask *)pullMessageWithMessageId:(NSString *)messageId
                                       sessionType:(int16_t)sessionType
                                       complection:(JSONResultBlock)complection;

/// 获取消息的已读未读列表
/// @param msgId 消息ID
/// @param complection 回调
- (NSURLSessionDataTask *)getReadStatusListForMsg:(NSString *)msgId complection:(JSONResultBlock)complection;





/// 拉取会话历史消息
/// @param sessionId 会话ID
/// @param sessionType 会话类型 0单聊，1群聊
/// @param securityType 安全类型，0普通，1密聊
/// @param type 消息类型 0 全部 ,1 文件 ,2 图片及视频
/// @param rows 获取数量
/// @param messageId 消息ID
/// @param searchName 搜索内容
/// @param complection 回调
- (NSURLSessionDataTask *)pullMessageOfSessionWithSessionId:(NSString *)sessionId
                                            withSessionType:(NSInteger)sessionType
                                           withSecurityType:(NSInteger)securityType
                                                   withType:(NSInteger)type
                                                   withRows:(NSInteger)rows
                                              withMessageId:(NSString *)messageId
                                             withSearchName:(NSString *)searchName
                                                complection:(JSONResultBlock)complection;
/// 查询最近一分钟音视频消息
/// @param complection 回调
- (NSURLSessionDataTask *)pullCallMsgsOfMinute:(JSONResultBlock)complection;

@end

NS_ASSUME_NONNULL_END
