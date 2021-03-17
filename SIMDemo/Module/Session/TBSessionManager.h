//
//  TBSessionManager.h
//  SIMDemo
//
//  Created by changxuanren on 2020/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBSessionManager : NSObject

+ (instancetype)sharedInstanced;

//获取会话信息（若远程无会话则会创建会话）
- (void)getSessionInfo:(NSString *)sessionId succ:(SIMGetSessionResultSucc)succ fail:(SIMFail)fail;

//置顶
- (void)topSessionWithSessionid:(NSString *)sessionId isTop:(BOOL)isTop succ:(SIMSucc)succ fail:(SIMFail)fail;

//免打扰
- (void)noDisturbSessionWithSessionid:(NSString*)sessionId isMute:(BOOL)isMute succ:(SIMSucc)succ fail:(SIMFail)fail;

//删除
- (void)delSession:(SIMSession *)session succ:(SIMSucc)succ fail:(SIMFail)fail;

//通过sessionId获取会话类型
- (SIMSessionType)getSIMSessionTypeOfSessionId:(NSString *)sessionId;

@end

NS_ASSUME_NONNULL_END
