//
//  SIMRecentMessage.h
//  AFNetworking
//
//  Created by 王杰 on 2019/7/5.
//

#import <Foundation/Foundation.h>
#import "SIMBaseMessage.h"
#import "SIMComm+Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMRecentMessage : SIMBaseMessage

/**
 *  最新消息时间戳
 */
@property (nonatomic,assign) long lastMsgTime;

/**
 *  登录时间戳
 */
@property (nonatomic,assign) long loginTime;

/**
 *  最后一条消息的后台ID
 */
@property (nonatomic,copy) NSString *tId;

/**
 *  搜索类型
 */
@property (nonatomic,assign) SIMRecentQueryType queryType;

@end


@interface SIMRecentMsgPage : NSObject

/**
 *
 */
@property (nonatomic,strong) NSArray *messageList;

/**
 *
 */
@property (nonatomic,assign) BOOL lastPage;

/**
 *  搜索类型
 */
@property (nonatomic,assign) SIMRecentQueryType queryType;

/**
 *  最新消息时间戳
 */
@property (nonatomic,assign) long lastMsgTime;

/**
 *  最后一条消息的后台ID
 */
@property (nonatomic,copy) NSString *tId;

/**
 *  
 */
@property (nonatomic,strong) NSArray *data;

@end

NS_ASSUME_NONNULL_END
