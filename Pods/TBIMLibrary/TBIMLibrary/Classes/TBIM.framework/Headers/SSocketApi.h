//
//  SSocketApi.h
//  NBIMDemo
//
//  这里是Socket提供到业务方的接口层。如果没有其他变化，该处逻辑代码是无需变化的。
//  如果消息通道协议改变，可以修改SSocket处逻辑
//  SSocketApi在后期本质上不会有太大变化，因为接口独立
//
//  on 2019/6/1.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMError.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SendDataBlock)(NSInteger command, _Nullable id response, SIMError * _Nullable error, _Nullable id req);

@protocol SSocketApiDelegate;

@interface SSocketApi : NSObject

+ (instancetype)sharedInstance;

/**
 连接Socket服务器
 
 @param host IM服务器地址（IP+端口或者域名）
 */
- (void)connectToHost:(NSString *)host completion:(nullable SendDataBlock)completion;
- (void)close;

/**
 注册Delegate服务
 
 @param delegate 客户方
 */
- (void)registServerDelegateServices:(id)delegate;
- (void)unRegistServerDelegateServices:(id)delegate;

/**
 发送消息
 
 string 将要发送信息的字符串
 data 二进制流
 dic 字典类型数据
 model 模型数据
 completion 外部自定义闭包，用于接收消息结果
 */
- (void)sendString:(NSString *)string completion:(nullable SendDataBlock)completion;

- (void)sendData:(NSData *)data completion:(nullable SendDataBlock)completion;

- (void)sendDictionary:(NSDictionary *)dic completion:(nullable SendDataBlock)completion;

- (void)sendModel:(id)model completion:(nullable SendDataBlock)completion;

@end


/**
 提供给外部的消息动态
 */
@protocol SSocketApiDelegate <NSObject>

@optional

/**
 收到服务器的消息，需要回调到各个业务方
 
 @param command 命令
 @param response 已经模型转换好的消息体（如果没有对应的命令模型，则不转换）
 @param error 错误消息
 */
- (void)SSocketReceiveMessage:(NSInteger)command response:(id)response error:(SIMError *)error;

/**
 因为未知原因导致Socket通道关闭了
 */
- (void)SSocketDidClosed;

@end

NS_ASSUME_NONNULL_END

