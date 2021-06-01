//
//  TBSessionManager.m
//  SIMDemo
//
//  on 2020/10/28.
//

#import "TBSessionManager.h"

@implementation TBSessionManager

- (void)getSessionInfo:(NSString *)sessionId succ:(SIMGetSessionResultSucc)succ fail:(SIMFail)fail {
    SIMSessionRequest * requset = [SIMSessionRequest new];
    requset.sessionId = sessionId;
    requset.sessionType = [[TBSessionManager sharedInstanced] getSIMSessionTypeOfSessionId:sessionId];
    requset.secType = SIMSecType_NORMAL;
    [[SIMSessionManager sharedInstance] getSessionInfo:requset succ:^(SIMSession * _Nonnull session) {
        succ ? succ(session) : nil;
    } fail:^(SIMError * _Nonnull error) {
        NSLog(@"SDK 获取会话信息失败：%@", error);
        fail? fail(error) : nil;
    }];
}

- (void)topSessionWithSessionid:(NSString *)sessionId isTop:(BOOL)isTop succ:(SIMSucc)succ fail:(SIMFail)fail {
    //先将sdk中的会话置顶
    SIMTopParam *param = [SIMTopParam new];
    param.sessionId = sessionId;
    param.sessionType = [[TBSessionManager sharedInstanced] getSIMSessionTypeOfSessionId:sessionId];
    param.securityType = SIMSecType_NORMAL;
    param.isTop = isTop;
    [[SIMSessionManager sharedInstance] setIsTop:param succ:^{
        succ ? succ() : nil;
    } fail:^(SIMError * _Nonnull error) {
        fail? fail(error) : nil;
    }];
}

- (void)noDisturbSessionWithSessionid:(NSString*)sessionId isMute:(BOOL)isMute succ:(SIMSucc)succ fail:(SIMFail)fail {
    SIMDisturbParam *param = [SIMDisturbParam new];
    param.sessionId = sessionId;
    param.sessionType = [[TBSessionManager sharedInstanced] getSIMSessionTypeOfSessionId:sessionId];
    param.securityType = SIMSecType_NORMAL;
    param.notDisturb = isMute;
    [[SIMSessionManager sharedInstance] setNotDisturb:param succ:^{
        succ ? succ() : nil;
    } fail:^(SIMError * _Nonnull error) {
        fail? fail(error) : nil;
    }];
}

- (void)delSession:(SIMSession *)session succ:(SIMSucc)succ fail:(SIMFail)fail {
    SIMSessionRequest * request = [SIMSessionRequest new];
    request.sessionId = session.sessionId;
    request.sessionType = [[TBSessionManager sharedInstanced] getSIMSessionTypeOfSessionId:session.sessionId];
    
    if (session.invalid) {
        [[SIMSessionManager sharedInstance] permanentlyDeleteSessionRequest:request succ:^{
            succ ? succ() : nil;
        } fail:^(SIMError * _Nonnull error) {
            fail? fail(error) : nil;
        }];
    }
    else {
        [[SIMSessionManager sharedInstance] deleteSessionRequest:request succ:^{
            succ ? succ() : nil;
        } fail:^(SIMError * _Nonnull error) {
            fail? fail(error) : nil;
        }];
    }
}

- (SIMSessionType)getSIMSessionTypeOfSessionId:(NSString *)sessionId {
    if ([sessionId hasPrefix:@"A_"]) {
        return SIMSessionType_P2P;
    }
    else {
        return SIMSessionType_GROUP;
    }
}

+ (instancetype)sharedInstanced {
    static TBSessionManager *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[TBSessionManager alloc] init];
    });
    return instance;
}

@end
