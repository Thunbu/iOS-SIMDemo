//
//  SIMBaseMessage.h
//  NBIMDemo
//
//  on 2019/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIMBaseMessage : NSObject

/*
 command-命令:
 0-心跳，1-登陆，2-登出，3-获取用户信息，4-设置用户信息，5-获取用户状态
 20-消息，21-服务端回执，22-客户端回执，23-已读，24-撤回，
 25-置顶，26-置顶通知，27-获取置顶列表
 // 群组相关
 40-创建群组，41-申请加入群组，42-申请加入群组通知，43-答复入群申请，44-入群申请结果通知，
 45-成员入群通知，46-邀请加入群组，47-邀请加入群组通知，48-答复入群邀请，49-入群邀请答复通知，
 50-退出群组，51-退出群组通知, 52-踢人，53-移除人员通知，54-解散群组，
 55-解散群组通知，56-获取群组成员，57-群组搜索，58-获取个人所在群组，59-修改群成员角色，
 60-群成员禁言，61-获取群成员名片，62-设置群成员名片，63-获取群组详情，64-设置群组详情
 65-设置群组免打扰
 // 账户和好友相关
 80-账号信息修改通知，83-好友申请通知，84-被添加通知，85-好友申请答复通知，
 87-删除好友通知, 88-删除所有好友通知, 89-好友标注修改通知
 // 会话相关
 90-会话创建通知，91-会话修改通知
 */
@property (nonatomic, assign) int command;

/**
 包唯一ID
 */
@property (nonatomic, copy) NSString *packetId;

/**
 应用Pass平台ID
 */
@property (nonatomic, copy) NSString *appId;

/**
 当前用户账号
 */
@property (nonatomic, copy) NSString *userId;

/**
 签名加密串
 */
@property (nonatomic, copy) NSString *userSig;

/**
 终端类型，0为mobile,1为pc或web端
 */
@property (nonatomic, assign) int terminal;

/**
 服务端给发送方回执结果（200表示成功）
 */
@property (nonatomic, assign) int result;

/**
 扩展字段
 */
@property (nonatomic, strong) id ext;

/// 标记红包是否点击
@property (nonatomic, assign) int redDarkenFlag; // 0 正常状态 1 点击过 变暗状态 当拿到服务端返回值的时候 统一放入 ECRedEnvelopesMsgBody redDarkenFlag 字段处理

@end

NS_ASSUME_NONNULL_END
