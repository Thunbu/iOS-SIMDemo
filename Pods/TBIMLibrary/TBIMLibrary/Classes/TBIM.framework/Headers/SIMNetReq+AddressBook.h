//
//  SIMNetReq+AddressBook.h
//  SIMSDK
//
//  on 2021/1/22.
//

#import "SIMNetReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMNetReq (AddressBook)

- (NSURLSessionDataTask *)TB_UserAddressBook:(NSDictionary *)params complection:(JSONResultBlock)complection;

- (NSURLSessionDataTask *)TB_UserInfo:(NSDictionary *)params complection:(JSONResultBlock)complection;
@end

NS_ASSUME_NONNULL_END
