//
//  SIMNetReq+IMSession.h
//  AFNetworking
//
//  on 2019/6/12.
//

#import "SIMNetReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMNetReq (IMSession)

/**
 拉取会话列表
 
 @param params 参数
 */
- (NSURLSessionDataTask *)pullSessionList:(NSDictionary *)params
                              complection:(JSONResultBlock)complection;

/**
 删除会话

 @param params 参数
 */
- (NSURLSessionDataTask *)delSession:(NSDictionary *)params
                         complection:(JSONResultBlock)complection;

/**
 删除会话
 
 @param params 参数
 */
- (NSURLSessionDataTask *)permanentlyDelSession:(NSDictionary *)params
                         complection:(JSONResultBlock)complection;


/**
 清空会话未读数

 @param params 参数
 */
- (NSURLSessionDataTask *)clearUnReadMsgCount:(NSDictionary *)params
                                  complection:(JSONResultBlock)complection;


/**
 拉取会话信息

 @param params 参数
 */
- (NSURLSessionDataTask *)pullSessionWihtParams:(NSDictionary *)params
                                    Complection:(JSONResultBlock)complection;


/// 拉取盒子会话信息
/// @param params 参数
/// @param complection 回调
- (NSURLSessionDataTask *)pullBoxChatSession:(NSDictionary *)params
                                 Complection:(JSONResultBlock)complection;


/**
 设置稍后处理
 */
- (NSURLSessionDataTask *)setSessionPostpone:(NSMutableArray *)sessions complection:(JSONResultBlock)complection;

/**
 获取稍后处理列表
 */
- (NSURLSessionDataTask *)postponeSessions:(JSONResultBlock)complection;
@end

NS_ASSUME_NONNULL_END
