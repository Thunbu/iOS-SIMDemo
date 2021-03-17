//
//  SIMListenerManager.h
//  NBIMDemo
//
//  Created by 一个工匠 on 2019/6/2.
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
 *  注册listener服务
 *
 *  @param listener 客户方
 */
- (void)registListenerServices:(id<SIMListener>)listener;

/**
 *  解除注册listener服务，和registListenerServices须要成对出现
 *
 *  @param listener 客户方
 */
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


#pragma mark 离线消息

/**
 *  离线消息
 *
 *  @param page 参数
 */
- (void)onReceiveRecentMessages:(SIMRecentMsgPage *)page;


#pragma mark 会话通知

/**
 *  会话通知变更通知
 *
 *  @param tip 变更详情
 */
- (void)onReceiveSessionTips:(SIMSessionTip *)tip;


#pragma mark 群通知

#pragma mark 好友

/**
 *  关系链资料变更通知
 *
 *  @param changeInfo 变更详情
 */
- (void)onReceiveSNSMessage:(SIMSNSChangeInfo *)changeInfo;


#pragma mark 自定义通知

/**
 *  自定义通知
 *
 *  @param custom 自定义通知消息体
 */
- (void)onReceiveCustomNotification:(SIMCustomNotification *)custom;


#pragma mark 多端登录状态

/**
 *  多端上/下线通知
 *
 *  @param loginMsg 通知内容
 */
- (void)onReceiveMultiterminalLoginState:(SIMMultiterminalLoginStateMessage *)loginMsg;


/**
 *  下线通知汇总
 *
 *  @param offlineMsg 通知内容
 */
- (void)onReceiveOfflineMessage:(SIMOfflineMessage *)offlineMsg;

@end

NS_ASSUME_NONNULL_END
