//
//  SIMAddressBookManager.h
//  SIMSDK
//
//  on 2021/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^JSONResultBlock)(id resultObject, NSError *error);

@interface SIMAddressBookManager : NSObject

+ (id)shareManager;

- (NSURLSessionDataTask *)TB_UserAddressBook:(NSDictionary *)params complection:(JSONResultBlock)complection;
- (NSURLSessionDataTask *)TB_UserInfo:(NSDictionary *)params complection:(JSONResultBlock)complection;
@end

NS_ASSUME_NONNULL_END
