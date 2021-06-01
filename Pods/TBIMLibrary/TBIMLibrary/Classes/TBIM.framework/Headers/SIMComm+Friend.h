//
//  SIMComm+Friend.h
//  NBIMDemo
//
//  on 2019/6/3.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import "SIMComm.h"

NS_ASSUME_NONNULL_BEGIN

@class SIMUserProfile;
@class SIMFriendListResponse;
@class SIMFriendResult;
@class SIMFriendPendencyResponse;

@interface SIMComm (Friend)


#pragma mark - 枚举类型

/**
 * 好友验证方式
 */
typedef NS_ENUM(NSInteger, SIMFriendAllowType) {
    /**
     *  同意任何用户加好友
     */
    SIM_FRIEND_ALLOW_ANY                    = 0,
    
    /**
     *  需要验证
     */
    SIM_FRIEND_NEED_CONFIRM                 = 1,
    
    /**
     *  拒绝任何人加好友
     */
    SIM_FRIEND_DENY_ANY                     = 2,
};

/**
 * 性别
 */
typedef NS_ENUM(NSInteger, SIMGender) {
    /**
     *  未知性别
     */
    SIM_GENDER_UNKNOWN      = 0,
    /**
     *  男性
     */
    SIM_GENDER_MALE         = 1,
    /**
     *  女性
     */
    SIM_GENDER_FEMALE       = 2,
    
};

typedef NS_ENUM(NSInteger, SIM_SNS_SYSTEM_TYPE){
    /**
     *  增加好友消息
     */
    SIM_SNS_SYSTEM_ADD_FRIEND              = 1,
    /**
     *  删除好友消息
     */
    SIM_SNS_SYSTEM_DEL_FRIEND              = 2,
    /**
     *  增加好友申请消息
     */
    SIM_SNS_SYSTEM_ADD_FRIEND_REQ          = 3,
    /**
     *  好友资料变更消息
     */
    SIM_SNS_SYSTEM_UPDATE_FRIEND           = 4
    
};

/**
 * 性别
 */
typedef NS_ENUM(NSInteger,SIMSexType){
    
    /** 男 */
    SIMSexType_Man = 1,
    
    /** 女 */
    SIMSexType_Woman = 2
};


typedef NS_ENUM(NSInteger, SIMDelFriendType) {
    /**
     *  删除单向好友
     */
    SIM_FRIEND_DEL_SINGLE               = 0,
    
    /**
     *  删除双向好友
     */
    SIM_FRIEND_DEL_BOTH                 = 1,
};

typedef NS_ENUM(NSInteger, SIMFriendResponseType) {
    //    /**
    //     *  同意加好友（建立单向好友）
    //     */
    //    SIM_FRIEND_RESPONSE_AGREE                       = 0,
    
    /**
     *  拒绝对方好友请求
     */
    SIM_FRIEND_RESPONSE_REJECT                      = 0,
    
    /**
     *  同意加好友并加对方为好友（建立双向好友）
     */
    SIM_FRIEND_RESPONSE_AGREE_AND_ADD               = 1
    
};

typedef NS_ENUM(NSInteger, SIMPendencyType) {
    /**
     *  我发给别人的
     */
    SIM_PENDENCY_SEND_OUT                   = 0,
    
    /**
     *  别人发给我的
     */
    SIM_PENDENCY_COME_IN                    = 1,
    
    /**
     * 别人发给我的 和 我发给别人的。仅拉取时有效
     */
    SIM_PENDENCY_BOTH                       = 2,
};


typedef NS_ENUM(NSInteger, SIMFriendPendencyItemType) {
    /**
     * 未操作
     */
     SIMFriendPendencyItemType_None  = 0,
    /**
     * 已添加
     */
     SIMFriendPendencyItemType_Added = 1,
    /**
     * 已申请
     */
     SIMFriendPendencyItemType_Applied = 2
    
};

#pragma mark - block 回调

/**
 *  获取资料回调
 *
 *  @param profile 资料
 */
typedef void (^SIMGetUserInfoSucc)(SIMUserProfile * profile);

/**
 *  获取资料回调
 *
 *  @param profiles 资料
 */
typedef void (^SIMGetUserInfoArraySucc)(NSArray<SIMUserProfile *> *profiles);


#pragma mark Friend

/**
 *  好友列表
 *
 *  @param friendListResponse 好友列表响应
 */
typedef void (^SIMGetFriendArraySucc)(SIMFriendListResponse * friendListResponse);


/**
 *  好友操作回调
 *
 *  @param result 资料
 */
typedef void (^SIMFriendResultSucc)(SIMFriendResult *result);

/**
 *  好友操作回调
 *
 *  @param results 资料
 */
typedef void (^SIMFriendResultArraySucc)(NSArray<SIMFriendResult *> *results);


/**
 * 获取未决请求列表成功
 *
 *  @param pendencyResponse 未决请求元信息
 */
typedef void (^SIMGetFriendPendencyListSucc)(SIMFriendPendencyResponse *pendencyResponse);

/**
 获取好友申请未读数成功回调

 @param number 未读数
 */
typedef void (^SIMGetFridenApplyUnReadSucc)(NSNumber * number);

@end

NS_ASSUME_NONNULL_END
