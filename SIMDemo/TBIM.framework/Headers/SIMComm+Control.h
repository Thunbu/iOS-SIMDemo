//
//  SIMComm+Control.h
//  NBIMDemo
//
//  Created by 一个工匠 on 2019/6/1.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import "SIMComm.h"
#import "SIMBaseMessage.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 枚举

/**
 * 日志级别
 */
typedef NS_ENUM(NSInteger, SIMLogLevel) {
    /**
     *  不输出任何 sdk log
     */
    SIM_LOG_NONE                = 0,
    /**
     *  输出 DEBUG，INFO，WARNING，ERROR 级别的 log
     */
    SIM_LOG_DEBUG               = 3,
    /**
     *  输出 INFO，WARNING，ERROR 级别的 log
     */
    SIM_LOG_INFO                = 4,
    /**
     *  输出 WARNING，ERROR 级别的 log
     */
    SIM_LOG_WARN                = 5,
    /**
     *  输出 ERROR 级别的 log
     */
    SIM_LOG_ERROR               = 6,
};

/**
 * 下线类型
 */
typedef NS_ENUM(NSInteger, SIMOfflineType) {
    /**
     *  主动下线
     */
    SIMOfflineType_Active        = 0,
    /**
     *  被挤下线
     */
    SIMOfflineType_Passive       = 1,
    /**
     *  踢用户其他在线终端
     */
    SIMOfflineType_PassiveOfMe   = 2,
    /**
     *  修改密码被下线
     */
    SIMOfflineType_ChangePassword = 3,
    /**
     *  账号被禁用
     */
    SIMOfflineType_AccountNoUse   = 4,
};


#pragma mark - Block

/**
 *  日志回调
 *
 *  @param lvl 输出的日志级别
 *  @param msg 日志内容
 */
typedef void (^SIMLogFunc)(SIMLogLevel lvl, NSString * msg);

#pragma mark - Model

/// 初始化 SDK 配置信息
@interface SIMSdkConfig : NSObject

/**
 *  用户标识接入 SDK 的应用 ID，必填
 */
@property (nonatomic,strong) NSString *sdkAppId;
@property (nonatomic,copy)NSString *budleId;
@property (nonatomic,copy)NSString *accountId;

/**
 *  Socket通道地址（IP+端口或者域名，若业务方没有配置，会使用默认值）
 */
@property (nonatomic,strong) NSString *socketDomain;

/**
 *  HTTP地址（IP+端口或者域名，若业务方没有配置，会使用默认值）
 */
@property (nonatomic,strong) NSString *httpDomain;

/**
 userSign
 */

@property (nonatomic, strong)NSString *userSignDomain;

/**
 *  用户的账号类型，必填
 */
@property (nonatomic,strong) NSString * accountType;

/**
 *  禁用 crash 上报，默认上报 (方法已废弃，客户需要自己集成 Crash 上报逻辑)
 */
@property (nonatomic,assign) BOOL disableCrashReport DEPRECATED_ATTRIBUTE;

/**
 *  禁止在控制台打印 log
 */
@property (nonatomic,assign) BOOL disableLogPrint;

/**
 *  本地写 log 文件的等级，默认 DEBUG 等级
 */
@property (nonatomic,assign) SIMLogLevel logLevel;

/**
 *  log 文件路径，不设置时为默认路径
 */
@property (nonatomic,strong) NSString * logPath;

/**
 *  回调给 log 函数的 log 等级，默认 DEBUG 等级
 */
@property (nonatomic,assign) SIMLogLevel logFuncLevel;

/**
 *  log 监听函数
 */
@property (nonatomic,copy) SIMLogFunc logFunc;

/**
 *  消息数据库路径，不设置时为默认路径
 */
@property (nonatomic,strong) NSString * dbPath;

/**
 *  网络监听器
 */
@property (nonatomic,strong) id<SIMConnListener> connListener;

/**
 *  允许OSS，暂不支持
 */
@property (nonatomic,assign,readonly) BOOL enableOSS;

@end


///登陆参数
@interface SIMLoginParam : SIMBaseMessage

/**
 *  用户名
 */
@property (nonatomic,strong) NSString* identifier;

/**
 *  鉴权 Token
 */
@property (nonatomic,strong) NSString* userSig;

/**
 *  App 用户使用 OAuth 授权体系分配的 Appid
 */
@property (nonatomic,strong) NSString* appidAt3rd;

/**
 *  关联用户信息，示例：@[@{@"appId":@"1", @"userId":@"001"}]
 */
@property (nonatomic,strong) NSArray *relatedUsers;

// 用户的项目 bundleId
@property(nonatomic, copy)NSString *bundleId;

@end


@interface SIMComm (Control)

@end

NS_ASSUME_NONNULL_END
