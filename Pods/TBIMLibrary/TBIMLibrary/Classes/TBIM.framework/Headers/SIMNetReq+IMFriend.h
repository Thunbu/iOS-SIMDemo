//
//  NBNetReq+IMFriend.h
//  NBIMDemo
//
//  on 2019/5/30.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import "SIMNetReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMNetReq (IMFriend)

/**
 添加好友

 @param identifier 好友ID
 @param reqDesc 申请理由
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask*)addFriendWithIdentifier:(NSString *)identifier withReqDesc:(NSString *)reqDesc complection:(JSONResultBlock)complection;

/**
 拉取好友列表

 @param page 页码
 @param size 每页数量
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask*)getFriendListPage:(NSInteger)page size:(NSInteger)size complection:(JSONResultBlock)complection;

/**
 删除好友

 @param identifer 好友ID
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)delFriendWithIdentifer:(NSString *)identifer type:(NSInteger)type complection:(JSONResultBlock)complection;


/**
 获取未决好友列表

 @param page 页码
 @param size 每页数据量
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)getPendencyListWithPage:(NSInteger)page size:(NSInteger)size type:(NSInteger)type Complection:(JSONResultBlock)complection;


/**
 响应好友申请

 @param userId 响应申请记录ID
 @param type 响应类型 0拒绝 1接受
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)doResponseWithUserId:(NSString *)userId type:(NSInteger)type Complection:(JSONResultBlock)complection;


/**
 获取好友申请未读数量
 
 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)getFriendApplyListUnreadNumberComplection:(JSONResultBlock)complection;


/**
 设置好友申请已读

 @param complection 回调
 @return 当前HTTP请求任务
 */
- (NSURLSessionDataTask *)setFriendApplyListReadComplection:(JSONResultBlock)complection;

@end

NS_ASSUME_NONNULL_END
