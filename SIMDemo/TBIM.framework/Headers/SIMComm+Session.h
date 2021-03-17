//
//  SIMComm+Session.h
//  NBIMDemo
//
//  Created by 一个工匠 on 2019/6/1.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import "SIMComm.h"
#import "SIMError.h"
#import "SIMComm+Message.h"

@class SIMSession;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 枚举类型

/**
 * 聊天类型：
 */
typedef NS_ENUM(NSInteger, SIMSecType) {
    /**
     *  非密聊
     */
    SIMSecType_NORMAL       = 0,
    
    /**
     *  密聊
     */
    SIMSecType_PRIVATE      = 1,
};

/**
 * 多端登录状态 (针对移动端多端登录状态)
 */
typedef NS_ENUM(NSInteger, SIMMultiterminalLoginState) {
    /**
     *  单终端在线
     */
    SIMMultiterminalLoginState_None                  = 0,
    
    /**
     *  PC端同时在线
     */
    SIMMultiterminalLoginState_PC                    = 1,
    
    /**
     *  Web端同时在线
     */
    SIMMultiterminalLoginState_Web                   = 2,
};



#pragma mark - Session

/**
 *  获取session列表回调
 *
 *  @param sessions 会话列表
 */
typedef void (^SIMGetSessionResultArraySucc)(NSArray <SIMSession *> *sessions);


/**
 *  获取会话信息成功回调
 *
 *  @param session 会话信息
 */
typedef void (^SIMGetSessionResultSucc)(SIMSession *session);

/**
 *  置顶
 */
@interface SIMTopParam : NSObject

/**
 *  会话Id
 */
@property (nonatomic, copy) NSString *sessionId;

/**
 *  会话类型
 */
@property (nonatomic, assign) SIMSessionType sessionType;

/**
 *  安全类型0普通，1私聊
 */
@property (nonatomic, assign) SIMSecType securityType;

/**
 *  是否置顶：0否，1是
 */
@property (nonatomic, assign) int isTop;

@end


/**
 *  免打扰
 */
@interface SIMDisturbParam : NSObject

/**
 *  会话Id
 */
@property (nonatomic, copy) NSString *sessionId;

/**
 *  会话类型
 */
@property (nonatomic, assign) SIMSessionType sessionType;

/**
 *  安全类型0普通，1私聊
 */
@property (nonatomic, assign) SIMSecType securityType;

/**
 *  是否免打扰：0否，1是
 */
@property (nonatomic, assign) int notDisturb;

@end


/**
 *  会话通知类消息
 */
@interface SIMSessionTip : NSObject

/**
 *  会话Id
 */
@property (nonatomic, copy) NSString *sessionId;

/**
 *  会话类型
 */
@property (nonatomic, assign) SIMSessionType sessionType;

/**
 *  安全类型0普通，1私聊
 */
@property (nonatomic, assign) SIMSecType securityType;

@end


@interface SIMSessionTopTip : SIMSessionTip
/**
 *  置顶
 */
@property (nonatomic, assign) BOOL isTop;
@end


@interface SIMSessionDisturbTip : SIMSessionTip
/**
 *  免打扰
 */
@property (nonatomic, assign) BOOL notDisturb;
@end


/**
 *  清空未读数
 */
@interface SIMSessionClearUnRead : SIMSessionTip

@end


/**
 *  会话删除
 */
@interface SIMSessionDeleteTip : SIMSessionTip

@end


/**
 *  会话请求体
 */
@interface SIMSessionRequest : NSObject

/**
 *  会话ID
 */
@property (nonatomic,strong) NSString * sessionId;

/**
 *  会话类型
 */
@property (nonatomic,assign) SIMSessionType sessionType;

/**
 *  安全类型
 */
@property (nonatomic,assign) SIMSecType secType;

@end


@interface SIMComm (Session)

@end



NS_ASSUME_NONNULL_END
