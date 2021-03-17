//
//  SIMNetReq+Common.h
//  AFNetworking
//
//  Created by changxuanren on 2019/11/18.
//

#import "SIMNetReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMNetReq (Common)

/// OSS授权访问接口
/// @param url 请求URL
/// @param headerField 请求头
/// @param complection 回调
- (NSURLSessionDataTask *)policyOSS:(NSString *)url headerField:(NSDictionary *)headerField complection:(JSONResultBlock)complection;

@end

NS_ASSUME_NONNULL_END
