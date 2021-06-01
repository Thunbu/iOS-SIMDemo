//
//  SIMSession.h
//  AFNetworking
//
//  on 2019/6/12.
//

#import <Foundation/Foundation.h>
#import "SIMComm+Message.h"
#import "SIMComm+Session.h"
#import "SIMComm+Group.h"

NS_ASSUME_NONNULL_BEGIN


@interface SIMSession : NSObject

/**
 是否置顶
 */
@property (nonatomic,assign) BOOL isTop;

/**
 是否显示
 */
@property (nonatomic,assign) BOOL isShow;

/**
 会话ID
 */
@property (nonatomic,strong) NSString * sessionId;

/**
 会话名称
 */
@property (nonatomic,strong) NSString * sessionName;

/**
 会话头像，情况下不够准确及时，一般情况下不使用
 */
@property (nonatomic, copy) NSString *avatar;

/**
 会话类型
 */
@property (nonatomic,assign) SIMSessionType sessionType;

/**
 是否免打扰
 */
@property (nonatomic,assign) BOOL isNoDisturb;


/**
 消息未读计数
 */
@property (nonatomic,assign) NSInteger messageCount;

/**
 安全类型
 */
@property (nonatomic,assign) SIMSecType securityType;

/**
 更新 时间戳
 */
@property (nonatomic,assign) long long updateTimeStamp;

/**
 最后一条消息
 */
@property (nonatomic,strong) SIMMessage * lastMessage;

/**
 群组类型 0私密群，1内部群，2讨论组，3事件群，4外部群
 */
@property (nonatomic,assign) SIMGroupType groupType;

/**
 置顶时间
 */
@property (nonatomic,assign) long long toppingTimeStamp;

/**
 会话有效性
 */
@property (nonatomic,assign) NSInteger invalid;

/**
 是否有at
 */
@property (nonatomic,assign) BOOL isAt;

/// 第一条未读消息ID
@property (nonatomic, copy) NSString *unreadFirstPacketId;

/**
 0表示不是外域，1表示为跨域
 */
@property (nonatomic,assign) NSInteger cross;

/**
 是否是稍后处理 0 不是 1 是
 */
@property (nonatomic,assign) NSInteger isLaterDeal;
@end

NS_ASSUME_NONNULL_END
