//
//  NBNetReq+IMUser.h
//  AFNetworking
//
//  on 2019/5/28.
//

#import "SIMNetReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMNetReq (IMUser)

#pragma mark - 资料管理

/**
 通过账号获取用户账号信息
 
 @param userId 用户ID
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)getPersonalData:(NSString *)userId
                              complection:(JSONResultBlock)complection;


/**
 设置用户信息
 
 @param userInfo 用户信息
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)setPersonalData:(NSDictionary *)userInfo
                              complection:(JSONResultBlock)complection;


#pragma mark - 账号管理

/**
 通过accounts集合获取用户账号信息
 
 @param userId  用户账号
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)getAccountByAccount:(NSString *)userId
                                  complection:(JSONResultBlock)complection;

/**
 通过accounts集合获取用户账号信息
 
 @param userIds accounts的json串
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)getAccountByAccounts:(NSString *)userIds
                                   complection:(JSONResultBlock)complection;


/**
 查询用户
 
 @param param   账号或昵称(0-50位)
 @param page    页号(1-99999999), 默认为1
 @param size    每页行数(1-100), 默认为100
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)accountPageList:(NSString *)param
                                     page:(NSInteger)page
                                     size:(NSInteger)size
                              complection:(JSONResultBlock)complection;


/**
 查询用户在线状态
 */
- (NSURLSessionDataTask *)userInlineStatus:(NSDictionary *)dic Complection:(JSONResultBlock)complection;

@end

NS_ASSUME_NONNULL_END
