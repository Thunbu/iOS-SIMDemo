//
//  SIMSessionManager.h
//  NBIMDemo
//
//  Created by changxuanren on 2019/6/4.
//  Copyright © 2019年 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMComm+Session.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMSessionManager : NSObject

+ (instancetype)sharedInstance;


/**
 *  置顶会话
 *
 *  @param param        置顶参数
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)setIsTop:(SIMTopParam *)param succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  免打扰会话
 *
 *  @param param        免打扰参数
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)setNotDisturb:(SIMDisturbParam *)param succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  会话设置
 *
 *  @param param        会话设置参数
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)setSession:(NSDictionary *)param succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  获取会话列表
 *
 *  @param sessionLevel 会话级别：0外层，1内层(订阅号需求必传参数)
 *  @param succ SIMGetSessionResultArraySucc 回调
 *  @param fail 失败
 *  @return 0：成功；1：失败
 */
- (int)getSessionList:(NSInteger)sessionLevel succ:(SIMGetSessionResultArraySucc)succ fail:(SIMFail)fail;


/**
 *  获取会话列表（增量更新）
 *
 *  @param sessionLevel 会话级别：0外层，1内层(订阅号需求必传参数)
 *  @param lastPullTime 上次请求时间戳
 *  @param succ SIMGetSessionResultArraySucc 回调
 *  @param fail 失败
 *  @return 0：成功；1：失败
 */
- (int)getSessionList:(NSInteger)sessionLevel lastPullTime:(NSString *)lastPullTime succ:(SIMGetSessionResultArraySucc)succ fail:(SIMFail)fail;


/**
 *  删除session 会话
 *
 *  @param request 请求体类型
 *  @param succ 成功回调
 *  @param fail 失败回调
 *  @return 0: 成功; 1:失败
 */
- (int)deleteSessionRequest:(SIMSessionRequest *)request succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  彻底删除session 会话
 *
 *  @param request 请求体类型
 *  @param succ 成功回调
 *  @param fail 失败回调
 *  @return 0: 成功; 1:失败
 */
- (int)permanentlyDeleteSessionRequest:(SIMSessionRequest *)request succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  清除会话未读数统计
 *
 *  @param request 请求体类型
 *  @param succ 成功回调
 *  @param fail 失败回调
 *  @return 请求task;
 */
- (void)clearUnReadMessageCountRequest:(SIMSessionRequest *)request;


/**
 *  获取会话信息
 *
 *  @param request 请求体类型
 *  @param succ 成功回调
 *  @param fail 失败回调
 *  @return 请求task;
 */
- (NSURLSessionDataTask *)getSessionInfo:(SIMSessionRequest*)request succ:(SIMGetSessionResultSucc)succ fail:(SIMFail)fail;


/**
 *  获取盒子会话信息
 *
 *  @param request 请求体类型
 *  @param succ 成功回调
 *  @param fail 失败回调
 *  @return 请求task;
 */
- (NSURLSessionDataTask *)getBoxChatSession:(SIMSessionRequest*)request succ:(SIMGetSessionResultSucc)succ fail:(SIMFail)fail;


@end

NS_ASSUME_NONNULL_END
