//
//  SIMNetReq+IMSession.h
//  AFNetworking
//
//  Created by 王杰 on 2019/6/12.
//

#import "SIMNetReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMNetReq (IMSession)

/**
 会话设置
 
 @param params  会话设置参数
 @param         complection 回调
 @return        当前HTTP请求任务
 */
- (NSURLSessionDataTask *)chatSessionSet:(NSDictionary *)params
                             complection:(JSONResultBlock)complection;
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

@end

NS_ASSUME_NONNULL_END
