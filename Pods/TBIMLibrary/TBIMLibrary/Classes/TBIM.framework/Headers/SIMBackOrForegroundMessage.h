//
//  SIMBackOrForegroundMessage.h
//  AFNetworking
//
//  on 2019/8/15.
//

#import "SIMBaseMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMBackOrForegroundMessage : SIMBaseMessage

/**
 进出后台状态，0进入后台，1进入前台
 */
@property(nonatomic,assign) int status;

/**
 消息发送时间
 */
@property(nonatomic,assign) long time;

/**
 终端类型，0: ios，1: Andriod
 */
@property(nonatomic,assign) int appType;

@end

NS_ASSUME_NONNULL_END
