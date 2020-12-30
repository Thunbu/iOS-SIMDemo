//
//  SIMBaseMessage.h
//  NBIMDemo
//
//  Created by changxuanren on 2019/4/25.
//  Copyright © 2019年 常宣任. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIMBaseMessage : NSObject

/*
 *  command-命令:
 *  0-心跳，1-登录，2-登出，……
 *  20-消息，21-服务端回执，22-客户端回执，23-已读，24-撤回，……
 */
@property (nonatomic, assign) int command;

/**
 *  包唯一ID
 */
@property (nonatomic, copy) NSString *packetId;

/**
 *  应用Pass平台ID
 */
@property (nonatomic, copy) NSString *appId;

/**
 *  当前用户账号
 */
@property (nonatomic, copy) NSString *userId;

/**
 *  签名加密串
 */
@property (nonatomic, copy) NSString *userSig;

/**
 *  终端类型，0为mobile,1为pc或web端
 */
@property (nonatomic, assign) int terminal;

/**
 *  服务端给发送方回执结果（200表示成功）
 */
@property (nonatomic, assign) int result;

/**
 *  扩展字段
 */
@property (nonatomic, strong) id ext;

@end

NS_ASSUME_NONNULL_END
