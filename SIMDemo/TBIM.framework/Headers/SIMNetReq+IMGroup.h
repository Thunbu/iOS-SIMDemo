//
//  NBNetReq+IMGroup.h
//  NBIMDemo
//
//  Created by changxuanren on 2019/5/29.
//  Copyright © 2019年 常宣任. All rights reserved.
//

#import "SIMNetReq.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMNetReq (IMGroup)

#pragma mark - 群管理

/**
 创建群组

 @param params 所有参数
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)createGroup:(NSDictionary *)params complection:(JSONResultBlock)complection;


/**
 *  查询群组信息
 
 *  @param groupId    群组ID
 */
- (NSURLSessionDataTask *)getGroupInfo:(NSString *)groupId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


/**
 *  设置群组信息
 
 *  @param groupInfo    群组对象
 */
- (NSURLSessionDataTask *)setGroupDetail:(NSDictionary *)groupInfo complection:(JSONResultBlock)complection;


/**
 *  解散群组
 
 *  @param groupId    群组ID
 *  @param userId     用户ID
 */
- (NSURLSessionDataTask *)disbandGroup:(NSString *)groupId userId:(NSString *)userId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


/**
 *  根据名称搜索群（只能搜索公开群-和聊天室）
 
 *  @param groupName    群组名称(0-50)
 */
- (NSURLSessionDataTask *)queryByGroupName:(NSString *)groupName complection:(JSONResultBlock)complection;


/**
 *  获取加入的所有群组
 */
- (NSURLSessionDataTask *)getAllUserGroupComplection:(JSONResultBlock)complection;


/**
 *  设置群公告
 
 *  @param notice   公告字符串，后期扩展为JSON字符串
 *  @param groupId  群ID
 */
- (NSURLSessionDataTask *)setGroupNotice:(NSString *)notice groupId:(NSString *)groupId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;

/// 切换@All的设置
/// @param groupId 群组ID
/// @param toggle 只能管理员@all的开关,关：0，开：1
/// @param complection 回调
- (NSURLSessionDataTask *)toggleAtallSetting:(NSString *)groupId toggle:(NSInteger)toggle groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


#pragma mark - 事件群

/**
 创建事件群

 @param params 群参数
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)createEventGroup:(NSDictionary *)params complection:(JSONResultBlock)complection;


/**
 设置事件群说明

 @param groupInfo 参数
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)setGroupEventExplain:(NSDictionary *)groupInfo complection:(JSONResultBlock)complection;

/**
 查询事件群的最新群公告详情

 @param explainId 群公告ID
 @param groupId 群组ID
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)getGroupEventExplainById:(NSString *)explainId groupId:(NSString *)groupId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;

/**
 根据ID查询群公告详情
 
 @param groupId 群组ID
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)getGroupEventExplainByGroupId:(NSString *)groupId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;

/**
 查询事件群公告历史

 @param groupId 群组ID
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)getGroupEventExplainHistory:(NSString *)groupId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


#pragma mark - 入群管理

/**
 *  申请-加入群组
 
 *  @param groupId    群组ID
 *  @param userId     用户ID
 *  @param reason     申请理由
 */
- (NSURLSessionDataTask *)applyJoinGroup:(NSString *)groupId userId:(NSString *)userId reason:(NSString *)reason groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


/**
 *  管理员验证入群申请
 
 *  @param applyId    申请记录ID
 *  @param userId     用户ID
 *  @param agree      答应是否同意
 */
- (NSURLSessionDataTask *)applyJoinGroupAck:(NSString *)applyId userId:(NSString *)userId agree:(BOOL)agree groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


/**
 *  邀请加入群组
 
 *  @param groupId    群组ID
 *  @param userId     用户ID
 *  @param userIds    邀请入群的所有人ID的json串
 *  @param type       0标识需要对方确认，1表示无需对方确认
 */
- (NSURLSessionDataTask *)inviteJoinGroup:(NSString *)groupId userId:(NSString *)userId userIds:(NSString *)userIds type:(NSInteger)type groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;

/// 更改邀请群成员的设置
/// @param groupId 群组ID
/// @param toggle 只能管理员邀请的开关，关：0，开：1
/// @param complection 回调
- (NSURLSessionDataTask *)toggleInvitedSetting:(NSString *)groupId toggle:(NSInteger)toggle groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


#pragma mark - 群成员管理

/**
 *  获取群组成员
 
 *  @param groupId    群组ID
 */
- (NSURLSessionDataTask *)getMembers:(NSString *)groupId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


/**
 *  踢人（群主能踢所有人，管理员只能踢普通人员，普通人员不能踢人）
 
 *  @param userIds    被踢人员ID数组，json格式的字符串
 *  @param groupId    群组ID
 *  @param userId     用户ID
 */
- (NSURLSessionDataTask *)removeGroupMember:(NSString *)userIds groupId:(NSString *)groupId userId:(NSString *)userId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;

/**
 *  群主-设置/取消群组管理员
 
 *  @param managerIds   群管理员ID，json格式的字符串
 *  @param groupId      群组ID
 *  @param userId       群主ID
 *  @param type         1设置管理员，2取消管理员
 */
- (NSURLSessionDataTask *)updateGroupManagers:(NSString *)managerIds groupId:(NSString *)groupId userId:(NSString *)userId type:(NSInteger)type groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


/**
 *  转让群主
 
 *  @param groupId      群ID
 *  @param newOwnerId   新群主ID
 *  @param userId       群主ID
 */
- (NSURLSessionDataTask *)changeGroupOwner:(NSString *)groupId newOwnerId:(NSString *)newOwnerId userId:(NSString *)userId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


/**
 *  设置群成员名片
 
 *  @param nickname     昵称(1-50)
 *  @param userId       用户ID
 */
- (NSURLSessionDataTask *)setMemberNickName:(NSString *)nickname userId:(NSString *)userId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


/**
 *  退出群组（群主退群需要先指定新的群主）

 *  @param groupId     群组ID
 */
- (NSURLSessionDataTask *)signOutGroup:(NSString *)groupId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


/// 搜索群名和群成员
/// @param text 关键字
/// @param complection 回调
- (NSURLSessionDataTask *)searchGroupByName:(NSString *)text complection:(JSONResultBlock)complection;

/// 根据手机号搜索群名和群成员
/// @param mobile 手机号
/// @param complection 回调
- (NSURLSessionDataTask *)searchGroupByMobile:(NSString *)mobile complection:(JSONResultBlock)complection;


#pragma mark - 音视频通话

/**
 获取群通话成员

 @param groupId 群ID
 @param complection 回调
 @return 请求任务
 */
- (NSURLSessionDataTask *)getVideoGroupUsers:(NSString *)groupId groupType:(NSInteger)groupType complection:(JSONResultBlock)complection;


@end

NS_ASSUME_NONNULL_END
