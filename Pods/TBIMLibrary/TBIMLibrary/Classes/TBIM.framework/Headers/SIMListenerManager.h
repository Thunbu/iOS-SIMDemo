//
//  SIMListenerManager.h
//  NBIMDemo
//
//  on 2019/6/2.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMSNSChangeInfo.h"
#import "SIMMessage.h"
#import "SIMCustomNotification.h"
#import "SIMRecentMessage.h"
#import "SIMMultiterminalLoginStateMessage.h"
#import "SIMOfflineMessage.h"

NS_ASSUME_NONNULL_BEGIN

@class SIMSessionTip;
@protocol SIMListener;

@interface SIMListenerManager : NSObject

+ (instancetype)sharedInstance;

/**
 注册listener服务
 
 @param listener 客户方
 */
- (void)registListenerServices:(id<SIMListener>)listener;
- (void)unRegistListenerServices:(id<SIMListener>)listener;

@end

@protocol SIMListener <NSObject>
@optional

#pragma mark 消息

/**
 *  新消息回调通知
 *
 *  @param msg SIMMessage 类型
 */
- (void)onReceivedMessage:(SIMMessage *)msg;

///**
// *  收到了已读回执
// *
// *  @param elem 已读消息
// */
//- (void)onRecvMessage:(SIMReadElem *)elem;

///**
// *  消息撤回通知
// *
// *  @param elem 被撤回消息
// */
//- (void)onRevokeMessage:(SIMRevokeElem *)elem;

///**
// *  消息删除通知
// *
// *  @param elem 被删除消息
// */
//- (void)onDeleteMessage:(SIMDeleteElem *)elem;

#pragma mark 离线消息

- (void)onReceiveRecentMessages:(SIMRecentMsgPage *)page;

#pragma mark 会话通知

- (void)onReceiveSessionTips:(SIMSessionTip *)tip;

#pragma mark 群通知

///**
// 群通知
//
// @param tips 群通知
// */
//- (void)onReceiveGroupTips:(SIMMessage *)tips;

///**
// 系统通知
//
// @param tips 系统通知
// */
//- (void)onReceiveSystemTips:(SIMMessage *)tips;

#pragma mark 好友

/**
 关系链资料变更通知
 @param changeInfo 变更详情
 */
- (void)onReceiveSNSMessage:(SIMSNSChangeInfo*)changeInfo;

#pragma mark 自定义通知

/**
 自定义通知

 @param custom 自定义通知消息体
 */
- (void)onReceiveCustomNotification:(SIMCustomNotification *)custom;

#pragma mark 多端登录状态

- (void)onReceiveMultiterminalLoginState:(SIMMultiterminalLoginStateMessage * )loginMsg;

/// 下线通知汇总
/// @param offlineMsg 通知内容
- (void)onReceiveOfflineMessage:(SIMOfflineMessage *)offlineMsg;

@end

NS_ASSUME_NONNULL_END
