//
//  SIMIMGroupManager.h
//  NBIMDemo
//
//  on 2019/5/29.
//

#import <Foundation/Foundation.h>
#import "SIMComm+Group.h"
#import "SIMError.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMGroupManager : NSObject

+ (instancetype)sharedInstance;

#pragma mark - 群管理

/**
 *  创建群组
 
 *  @param groupName  群组名称
 *  @param type       群组类型，0私密群，1公开群，2讨论组
 *  @param userIds    群组成员ID数组
 *  @param succ       成功回调
 *  @param fail       失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)createGroup:(NSString *)groupName type:(int)type userIds:(NSArray *)userIds succ:(SIMCreateGroupSucc)succ fail:(SIMFail)fail;

/**
 创建群组通用接口

 @param params 所有参数
 @param succ 成功回调
 @param fail 失败回调
 @return 0：成功；1：失败
 */
- (int)createGroup:(NSDictionary *)params succ:(SIMCreateGroupSucc)succ fail:(SIMFail)fail;


/**
 *  查询群组信息
 
 *  @param groupId    群组ID
 *  @param succ       成功回调
 *  @param fail       失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)getGroupInfo:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMGetGroupSucc)succ fail:(SIMFail)fail;


/**
 *  设置群组信息
 *
 *  @param groupId    群组ID
 *  @param groupInfo    群组对象
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)setGroupDetail:(NSString *)groupId groupInfo:(NSDictionary *)groupInfo succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  解散群组
 *
 *  @param groupId      群组ID
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)disbandGroup:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  根据名称搜索群（只能搜索公开群-和聊天室）
 
 *  @param groupName    群组名称(0-50)
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)queryByGroupName:(NSString *)groupName groupType:(SIMGroupType)groupType succ:(SIMGetGroupsSucc)succ fail:(SIMFail)fail;


/**
 *  获取加入的所有群组
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)getAllUserGroupSucc:(SIMGetGroupsSucc)succ fail:(SIMFail)fail;


/**
 *  设置群公告
 
 *  @param notice   公告字符串，后期扩展为JSON字符串
 *  @param groupId  群ID
 *
 *  @return 0：成功；1：失败
 */
- (int)setGroupNotice:(NSString *)notice groupId:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;

/// 切换@All的设置
/// @param groupId 群组ID
/// @param toggle 只能管理员@all的开关,关：0，开：1
/// @param succ 成功回调
/// @param fail 失败回调
- (int)toggleAtAll:(NSString *)groupId toggle:(NSInteger)toggle groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


#pragma mark - 事件群

/*
 群代办确认
 */
- (void)groupChangeEventStatus:(NSDictionary *)dic succ:(SIMSuccData)succ fail:(SIMFail)fail;
- (void)groupProhibitInfo:(NSDictionary *)dic succ:(SIMSuccData)succ fail:(SIMFail)fail;
/*全员禁言*/
- (void)groupAllProhibit:(NSDictionary *)dic succ:(SIMSuccData)succ fail:(SIMFail)fail;
/*
 添加禁言成员或者添加可发言成员
 */
- (void)groupAddProhibitMembers:(NSDictionary *)params succ:(SIMSuccData)succ fail:(SIMFail)fail;
/*
 解除禁言 / 移除可发言成员接口
 */
- (void)groupCancleProhibitMembers:(NSDictionary *)params succ:(SIMSuccData)succ fail:(SIMFail)fail;
/**
 创建事件群

 @param params 参数
 @param succ 成功回调
 @param fail 失败回调
 @return 0：成功；1：失败
 */
- (int)createEventGroup:(NSDictionary *)params succ:(SIMCreateGroupSucc)succ fail:(SIMFail)fail;

/**
 设置事件群说明

 @param groupId 群组ID
 @param groupInfo 设置参数字典
 @param succ 成功回调
 @param fail 失败回调
 @return 0：成功；1：失败
 */
- (int)setGroupEventExplain:(NSString *)groupId groupInfo:(NSDictionary *)groupInfo succ:(SIMSucc)succ fail:(SIMFail)fail;

/**
 查询事件群的最新群公告详情

 @param groupId 群组ID
 @param succ 成功回调
 @param fail 失败回调
 @return 0：成功；1：失败
 */
- (int)getGroupEventExplainByGroupId:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMSuccData)succ fail:(SIMFail)fail;

/**
 根据ID查询群公告详情
 
 @param explainId 群公告ID
 @param groupId 群组ID
 @param succ 成功回调
 @param fail 失败回调
 @return 0：成功；1：失败
 */
- (int)getGroupEventExplainById:(NSString *)explainId groupId:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMSuccData)succ fail:(SIMFail)fail;

/**
 查询事件群公告历史
 
 @param groupId 群组ID
 @param succ 成功回调
 @param fail 失败回调
 @return 0：成功；1：失败
 */
- (int)getGroupEventExplainHistory:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMSuccData)succ fail:(SIMFail)fail;


#pragma mark - 入群管理

/**
 *  申请-加入群组
 *
 *  @param groupId    群组ID
 *  @param reason     申请理由
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)applyJoinGroup:(NSString *)groupId reason:(NSString *)reason groupType:(SIMGroupType)groupType succ:(SIMApplyJoinGroupSucc)succ fail:(SIMFail)fail;


/**
 *  管理员验证入群申请
 
 *  @param applyId    申请记录ID
 *  @param agree      答应是否同意
 *  @param succ       成功回调
 *  @param fail       失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)applyJoinGroupAck:(NSString *)applyId agree:(BOOL)agree groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  邀请加入群组
 
 *  @param groupId    群组ID
 *  @param userIds    邀请入群的所有人ID数组
 *  @param succ       成功回调
 *  @param fail       失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)inviteJoinGroup:(NSString *)groupId userIds:(NSArray *)userIds groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;

/// 更改邀请群成员的设置
/// @param groupId 群组ID
/// @param toggle 只能管理员邀请的开关，关：0，开：1
/// @param succ 成功回调
/// @param fail 失败回调
- (int)toggleInvite:(NSString *)groupId toggle:(NSInteger)toggle groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


#pragma mark - 群成员管理

/**
 *  获取群组成员
 
 *  @param groupId    群组ID
 *  @param succ       成功回调
 *  @param fail       失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)getMembers:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMGetGroupMembersSucc)succ fail:(SIMFail)fail;


/**
 *  踢人（群主能踢所有人，管理员只能踢普通人员，普通人员不能踢人）
 
 *  @param userIds    被踢人员ID数组
 *  @param groupId    群组ID
 *  @param succ       成功回调
 *  @param fail       失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)removeGroupMember:(NSArray *)userIds groupId:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  群主-设置群组管理员
 
 *  @param managerIds   群管理员ID数组
 *  @param groupId      群组ID
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)setGroupManagers:(NSArray *)managerIds groupId:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  群主-取消群组管理员
 
 *  @param managerIds   群管理员ID数组
 *  @param groupId      群组ID
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)removeGroupManagers:(NSArray *)managerIds groupId:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  转让群主
 
 *  @param groupId      群ID
 *  @param newOwnerId   新群主ID
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)changeGroupOwner:(NSString *)groupId newOwnerId:(NSString *)newOwnerId groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  设置我的群名片
 
 *  @param nickname     昵称(1-50)
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)setMemberNickName:(NSString *)nickname groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


/**
 *  退出群组（群主退群需要先指定新的群主）
 
 *  @param groupId     群组ID
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0：成功；1：失败
 */
- (int)signOutGroup:(NSString *)groupId groupType:(SIMGroupType)groupType succ:(SIMSucc)succ fail:(SIMFail)fail;


/// 搜索群名和群成员
/// @param text 关键字
/// @param succ 成功回调
/// @param fail 失败回调
- (int)searchGroupByName:(NSString *)text succ:(SIMSuccData)succ fail:(SIMFail)fail;

/// 根据手机号搜索群名和群成员
/// @param mobile 手机号
/// @param succ 成功回调
/// @param fail 失败回调
- (int)searchGroupByMobile:(NSString *)mobile succ:(SIMSuccData)succ fail:(SIMFail)fail;


@end

NS_ASSUME_NONNULL_END
