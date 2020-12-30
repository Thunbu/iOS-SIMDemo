//
//  SIMCall.h
//  AFNetworking
//
//  Created by changxuanren on 2019/7/29.
//

#import "SIMBaseMessage.h"
#import "SIMComm+Message.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  音视频通话参数
 */
@interface SIMCallMessage : SIMBaseMessage

/**
 *  消息发送时间
 */
@property(nonatomic,assign) long time;

/**
 *  通话结束时间
 */
@property(nonatomic,assign) long overTimes;

/**
 *  通话类型 0: 音频 1：视频
 */
@property(nonatomic,assign) int communicateType;

/**
 *  通道id
 */
@property(nonatomic,copy) NSString *conId;

/**
 *  通道保持：heartBeat
 *  单聊：1.发起 uCreate 2.取消 uCancel 3.接受 uAccept 4.拒绝 uRefuse 6.挂断 uHangUp 7.忙线中 uBusy
 *  群聊：1.发起 gCreate 2.邀请 gInvite 3.主动加入 gJoin 4.接受 gAccept 5.拒绝 gRefuse 7.挂断 gHangUp
 */
@property(nonatomic,copy) NSString *method;

/**
 *  发送方账号
 */
@property(nonatomic,copy) NSString *sender;

/**
 *  用户姓名
 */
@property(nonatomic,copy) NSString *displayName;

/**
 *  接收人账号
 */
@property(nonatomic,copy) NSString *receiver;

/**
 *  不包含自己的人员列表，json格式，例如[001,002]
 */
@property(nonatomic,copy) NSString *userIds;

/**
 *  NO表示不是外域，YES表示为跨域，默认为NO
 */
@property (nonatomic,assign) BOOL cross;

/**
 *  初始化
 *
 *  @param receiver 接收方
 *  @return SIMCall实例
 */
- (instancetype)initWithReceiver:(NSString *)receiver;


@end

NS_ASSUME_NONNULL_END
