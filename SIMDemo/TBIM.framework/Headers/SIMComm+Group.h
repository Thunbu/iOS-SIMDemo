//
//  SIMComm+Group.h
//  NBIMDemo
//
//  Created by changxuanren on 2019/6/4.
//  Copyright © 2019年 闪布科技. All rights reserved.
//

#import "SIMComm.h"
#import "SIMError.h"

NS_ASSUME_NONNULL_BEGIN

@class SIMGroupInfo, SIMGroupNotice, SIMGroupMemberInfo;
#pragma mark - 宏定义

#define SIMGroupDetailChangedKeys_AVATAR  @"avatar"
#define SIMGroupDetailChangedKeys_NAME  @"groupName"
#define SIMGroupDetailChangedKeys_NOTICE  @"notice"
#define SIMGroupDetailChangedKeys_ISREVIEW  @"isReview"
#define SIMGroupDetailChangedKeys_TEXT  @"text"
#define SIMGroupDetailChangedKeys_USERIDS  @"userIds"
#define SIMGroupDetailChangedKeys_IMAGEINFO  @"imageInfo"
#define SIMGroupDetailChangedKeys_FILEINFO  @"fileInfo"

#pragma mark - 枚举类型

/**
 *  群组类型
 */
typedef NS_ENUM(NSInteger, SIMGroupType) {
    SIMGroupType_Private = 0, //私有群
    SIMGroupType_Internal = 1, //公开群-内部群
    SIMGroupType_Discuss = 2, //讨论组
    SIMGroupType_Event = 3, //事件群
    SIMGroupType_Public = 4, //外部群
    SIMGroupType_Organized = 5, //组织群
    SIMGroupType_Meeting = 6, //会议的讨论组
};

typedef NS_ENUM(NSInteger, SIMGroupTipsType) {
    SIMGroupTipsType_APPLY = 1, // 申请通知
    SIMGroupTipsType_APPLY_ACK, //申请确认通知
    SIMGroupTipsType_JOIN, // 有人加入通知
    SIMGroupTipsType_QUIT, // 退出群聊通知
    SIMGroupTipsType_REMOVE_MEMBER, // 剔除人员通知
    SIMGroupTipsType_DISBAND_GROUP, // 解散群通知
    SIMGroupTipsType_MODIFY_GROUPINFO, // 群资料修改
    SIMGroupTipsType_CHANGE_ROLE, // 更改角色
};

/**
 *  群成员角色
 */
typedef NS_ENUM(NSInteger, SIMGroupMemberRole) {
    /**
     *  群主
     */
    SIM_GROUP_MEMBER_ROLE_SUPER               = 0,
    
    /**
     *  群管理员
     */
    SIM_GROUP_MEMBER_ROLE_ADMIN               = 1,
    
    /**
     *  群成员
     */
    SIM_GROUP_MEMBER_ROLE_MEMBER              = 2,
};


#pragma mark - block 回调

/**
 *  群创建成功
 *
 *  @param groupId 群组 Id
 */
typedef void (^SIMCreateGroupSucc)(NSString *groupId);

/**
 *  群信息查询成功
 *
 *  @param groupInfo 群组信息对象
 */
typedef void (^SIMGetGroupSucc)(SIMGroupInfo *groupInfo);

/**
 *  群列表查询成功
 *
 *  @param groups 群信息对象
 */
typedef void (^SIMGetGroupsSucc)(NSArray<SIMGroupInfo *> *groups);

/**
 *  群成员列表查询成功
 *
 *  @param groupMembers 群成员信息对象
 */
typedef void (^SIMGetGroupMembersSucc)(NSArray<SIMGroupMemberInfo *> *groupMembers);

/**
 *  申请-加入群组成功
 *
 *  @param applyId  申请记录ID
 */
typedef void (^SIMApplyJoinGroupSucc)(NSString *applyId);


#pragma mark - 基础类型

/**
 *  群资料信息
 */
@interface SIMGroupInfo : NSObject

/**
 *  群组 Id
 */
@property(nonatomic,strong) NSString *groupId;

/**
 *  群主账号
 */
@property(nonatomic,strong) NSString *ownerId;

/**
 *  群头像
 */
@property(nonatomic,strong) NSString *avatar;

/**
 *  群创建人
 */
@property(nonatomic,strong) NSString *createBy;

/**
 *  创建时间
 */
@property(nonatomic,strong) NSString *createTime;

/**
 *  是否解散：0正常，1解散
 */
@property(nonatomic,strong) NSString *delFlag;

/**
 *  创建时间
 */
@property(nonatomic,strong) NSArray<SIMGroupMemberInfo *> *groupMembers;

/**
 *  群成员数量
 */
@property(nonatomic,assign) NSInteger num;

/**
 *  群组类型 0私密群，1内部群，2讨论组，3事件群，4外部群，5组织群
 */
@property(nonatomic,assign) SIMGroupType groupType;

/**
 *  用户状态: 1需要审核，0不需要审核
 */
@property(nonatomic,assign) uint32_t isReview;

/**
 *  人数上限
 */
@property(nonatomic,assign) uint32_t maxCount;

/**
 *  群组名称
 */
@property(nonatomic,strong) NSString *name;

/**
 *  群公告
 */
@property(nonatomic,strong) SIMGroupNotice *groupNotice;

/**
 *  修改人
 */
@property(nonatomic,assign) uint32_t updateBy;

/**
 *  修改时间
 */
@property(nonatomic,strong) NSString *updateTime;

/**
 *  0：全部成员可添加群成员，1：仅群主及管理员可添加群成员
 */
@property(nonatomic,assign) NSInteger invitedToggle;

/**
 *  0：全部成员可@所有人，1：仅群主及管理员可@所有人
 */
@property(nonatomic,assign) NSInteger atallToggle;

@end



/**
 *  群公告
 */
@interface SIMGroupNotice : NSObject

/**
 *  主键
 */
@property(nonatomic,strong) NSString *noticeID;

/**
 *  公告内容
 */
@property(nonatomic,strong) NSString *notice;

/**
 *  创建人
 */
@property(nonatomic,strong) NSString *createBy;

/**
 *  创建人昵称
 */
@property(nonatomic,strong) NSString *createName;

/**
 *  创建时间
 */
@property(nonatomic,strong) NSString *createTime;

/**
 *  修改时间
 */
@property(nonatomic,strong) NSString *updateTime;

/**
 *  是否被删除
 */
@property(nonatomic,assign) BOOL delFlag;

/**
 *  群ID
 */
@property(nonatomic,assign) uint64_t groupId;

@end



/**
 *  群成员资料
 */
@interface SIMGroupMemberInfo : NSObject

/**
 *  主键
 */
@property(nonatomic,strong) NSString *primaryKey;

/**
 *  成员id
 */
@property(nonatomic, copy) NSString *userId;

/**
 *  群ID
 */
@property(nonatomic,assign) uint64_t groupId;

/**
 *  群成员姓名
 */
@property(nonatomic,strong) NSString *nickname;

/**
 *  群成员昵称
 */
@property(nonatomic,strong) NSString *petName;

/**
 *  本人被谁邀请进群的（非邀请的情况，本字段则可为空）
 */
@property(nonatomic, copy) NSString * beInviteId;

/**
 *  如是群的被转让人，本字段填的就是最近一次被转让时的时间
 */
@property(nonatomic,strong) NSString *beOwnerTime;

/**
 *  群创建人
 */
@property(nonatomic,strong) NSString *createBy;

/**
 *  加入群组时间
 */
@property(nonatomic, copy) NSString * createTime;

/**
 *  删除标识，0代表为删除，1代表已删除
 */
@property(nonatomic,assign) uint32_t delFlag;

/**
 *  免打扰（1表示消息免打扰）
 */
@property(nonatomic,assign) uint32_t disturb;

/**
 *  消息置顶（1表示置顶）
 */
@property(nonatomic,assign) uint32_t top;

/**
 *  用户角色（0群主，1管理员，2普通用户）
 */
@property(nonatomic,assign) SIMGroupMemberRole role;

/**
 *  修改人
 */
@property(nonatomic, copy) NSString *updateBy;

/**
 *  修改时间
 */
@property(nonatomic,strong) NSString *updateTime;

@end

@interface SIMComm (Group)

@end

NS_ASSUME_NONNULL_END
