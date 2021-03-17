//
//  SIMManager.h
//  NBIMDemo
//
//  Created by 王杰 on 2019/5/28.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMCallBack.h"
#import "SIMMessage.h"
#import "SIMComm+Control.h"

static NSString *MarsIMSDKConnectionStatusNoti = @"MarsIMSDKConnectionStatusNoti";

NS_ASSUME_NONNULL_BEGIN

@protocol SIMConnListener;

@interface SIMManager : NSObject

@property (nonatomic, strong) SIMSdkConfig *sdkConfig;
@property (nonatomic, strong) SIMLoginParam *loginParam;

+ (instancetype)sharedInstance;

/**
 *  初始化 SDK，设置全局配置信息
 *
 *  @param config 配置信息
*/
- (int)initSdk:(SIMSdkConfig*)config;


/**
 登录SDK 统一入口
 */

- (void)TBIM_loginSDK:(SIMSuccData)succ fail:(SIMFail)fail;

/**
 *  登录
 *
 *  @param param 登陆参数
 *  @param succ  成功回调
 *  @param fail  失败回调
 */
- (void)login:(SIMLoginParam*)param succ:(SIMSuccData)succ fail:(SIMFail)fail;


/**
 *  用户登出IM
 *
 *  @param succ  成功回调
 *  @param fail  失败回调
 */
- (void)logout:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  强制退出IM
 */
- (void)forceLogout;


/**
 *  注册listener服务
 *
 *  @param listener 客户方
 */
- (void)registListenerServices:(id<SIMConnListener>)listener;


/**
 *  解除注册listener服务，须要和registListenerServices成对出现
 *
 *  @param listener 客户方
 */
- (void)unRegistListenerServices:(id<SIMConnListener>)listener;


/**
 *  尝试重连Socket
 */
- (void)tryToCycleLogin;


#pragma mark - 设置 APNs 推送

/**
 *  APP 进入后台
 *
 *  APP 进后台的时候需要主动调用 doBackground ，这个时候后台知道 APP 的状态，之后的消息会下发推送通知。
 *
 *  @param succ       成功回调
 *  @param fail       失败回调
 */
- (void)doBackground:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  APP 进入前台
 *
 *  APP 进前台的时候需要主动调用 doForeground。
 *
 *  @param succ       成功回调
 *  @param fail       失败回调
 */
- (void)doForeground:(SIMSucc)succ fail:(SIMFail)fail;


@end


/**
 *  连接通知回调
 */
@protocol SIMConnListener <NSObject>
@optional

/**
 *  网络连接成功
 */
- (void)onConnSucc;


/**
 *  网络连接失败
 *
 *  @param err 错误说明
 */
- (void)onConnFailed:(SIMError *)err;


/**
 *  连接中
 */
- (void)onConnecting;


/**
 *  重连成功
 */
- (void)relinkSucc;

@end

NS_ASSUME_NONNULL_END
