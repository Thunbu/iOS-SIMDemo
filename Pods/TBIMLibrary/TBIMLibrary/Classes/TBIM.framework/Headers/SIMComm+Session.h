//
//  SIMComm+Session.h
//  NBIMDemo
//
//  on 2019/6/1.
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
 获取session列表回调

 @param sessions 会话列表
 */
typedef void (^SIMGetSessionResultArraySucc)(NSArray <SIMSession *> *sessions);

typedef void (^SIMGetSessionResultSucc)(SIMSession *session);
/*
 置顶
 */
@interface SIMTopParam : NSObject

@property (nonatomic, copy) NSString *sessionId; //会话Id

@property (nonatomic, assign) SIMSessionType sessionType; //会话类型

@property (nonatomic, assign) SIMSecType securityType; //安全类型0普通，1私聊

@property (nonatomic, assign) int isTop; //是否置顶：0否，1是

@end


/*
 免打扰
 */
@interface SIMDisturbParam : NSObject

@property (nonatomic, copy) NSString *sessionId; //会话Id

@property (nonatomic, assign) SIMSessionType sessionType; //会话类型

@property (nonatomic, assign) SIMSecType securityType; //安全类型0普通，1私聊

@property (nonatomic, assign) int notDisturb; //是否免打扰：0否，1是

@end

/**
 会话通知类消息
 */
@interface SIMSessionTip : NSObject
@property (nonatomic, copy) NSString *sessionId; //会话Id
@property (nonatomic, assign) SIMSessionType sessionType; //会话类型
@property (nonatomic, assign) SIMSecType securityType; //安全类型0普通，1私聊
@end

@interface SIMSessionTopTip : SIMSessionTip
@property (nonatomic, assign) BOOL isTop; //置顶
@end

@interface SIMSessionPostpone : SIMSessionTip

@property (nonatomic, assign) int isLaterDeal; //稍后处理
@end

@interface SIMSessionDisturbTip : SIMSessionTip
@property (nonatomic, assign) BOOL notDisturb; //免打扰
@end

@interface SIMSessionClearUnRead : SIMSessionTip //清空未读数

@end

@interface SIMSessionDeleteTip : SIMSessionTip //会话删除

@end


/**
 会话请求体
 */
@interface SIMSessionRequest : NSObject

@property (nonatomic,strong) NSString * sessionId; //会话ID

@property (nonatomic,assign) SIMSessionType sessionType; //会话类型

@property (nonatomic,assign) SIMSecType secType; //安全类型

@end


@interface SIMComm (Session)

@end



NS_ASSUME_NONNULL_END
