//
//  SSocket.h
//  NBIMDemo
//
//  这里是Socket核心通道，目前走的WebSocket逻辑。
//  如果后期需要其他协议，可以抛弃该处代码，直接另建文件重写Socket通道
//  SSocketApi是外界接口，这里仅仅提供Socket通道，如果后期通道协议改变，新的文件对接SSocketApi即可快速完成通道变迁工作
//
//  on 2019/5/5.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SocketRocket.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SSocketDelegate;

@interface SSocket : NSObject

@property (nonatomic, strong, readonly) SRWebSocket *socket;

// Socket实时代理回调
@property (nonatomic, weak) id <SSocketDelegate> ssocketDelegate;

+ (instancetype)sharedInstance;

/**
 通过Url连接Socket通道

 @param url 连接URL
 */
- (void)connectWithUrl:(NSURL *)url;

/**
 关闭Socket通道
 */
- (void)close;

/**
 发送字节消息
 
 @param data 传输字节内容
 */
- (void)sendData:(NSData *)data;

@end

/**
 将Socket通道产生的数据，实时回调到外部
 */
@protocol SSocketDelegate <NSObject>
// 接收到了新数据
- (void)webSocketDidReceiveMessage:(id)message;

@optional
// socket通道已经打开
- (void)webSocketDidOpen;
// socket通道已经关闭
- (void)webSocketDidFailWithError:(NSError *)error;
// socket通道已经关闭
- (void)webSocketDidCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
// 收到服务器的pingpong消息
- (void)webSocketDidReceivePong:(NSData *)pongPayload;

@end

NS_ASSUME_NONNULL_END

