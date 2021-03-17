//
//  SIMNetReq+Login.h
//  SIMSDK
//
//  Created by xiaobing on 2020/12/28.
//

#import "SIMNetReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMNetReq (Login)


- (NSURLSessionDataTask *)preLoginSDK:(NSDictionary *)params url:(NSString *)url complection:(JSONResultBlock)complection;
@end

NS_ASSUME_NONNULL_END
