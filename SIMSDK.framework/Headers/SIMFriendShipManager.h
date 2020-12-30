//
//  SIMFridenManager.h
//  NBIMDemo
//
//  Created by 王杰 on 2019/5/27.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMFriend.h"

@class SIMFriend;

NS_ASSUME_NONNULL_BEGIN
// 用户资料KEY

/**
 * 昵称
 * 值类型: NSString
 */
extern NSString *const SIMUserInfoTypeKey_Nick;
/**
 * 头像
 * 值类型: NSString
 */
extern NSString *const SIMUserInfoTypeKey_FaceUrl;
/**
 * 好友申请
 * 值类型: NSNumber [TIM_FRIEND_ALLOW_ANY,TIM_FRIEND_NEED_CONFIRM,TIM_FRIEND_DENY_ANY]
 */
//extern NSString *const SIMUserInfoTypeKey_AllowType;
/**
 * 性别
 * 值类型: NSNumber [TIM_GENDER_UNKNOWN,TIM_GENDER_MALE,TIM_GENDER_FEMALE]
 */
extern NSString *const SIMUserInfoTypeKey_Gender;
/**
 * 生日
 * 值类型: NSNumber
 */
extern NSString *const SIMUserInfoTypeKey_Birthday;

/**
 * 签名
 * 值类型: NSString
 */
extern NSString *const TuserInfoTypeKey_SelfSignature;

/**
 * 电话号码
 * 值类型: NSString
 */
extern NSString *const TuserInfoTypeKey_MPhone;

/**
 * 地区
 * 值类型: NSString
 */
extern NSString *const TuserInfoTypeKey_Region;


/**
 * 自定义字段前缀
 * 值类型: [NSString,NSData|NSNumber]
 * @note 当设置自定义字的值NSString对象时，后台会将其转为UTF8保存在数据库中。由于部分用户迁移资料时可能不是UTF8类型，所以在获取资料时，统一返回NSData类型。
 */
extern NSString *const TuserInfoTypeKey_Custom_Prefix;


@interface SIMFriendShipManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) SIMUserProfile * userInfo; //自己的信息


#pragma mark - 用户资料

/**
 *  获取自己的资料
 *  @param succ  成功回调，返回 SIMUserInfo
 *  @param fail  失败回调
 *  @return 0 发送请求成功
 */
- (int)getSelfProfile:(SIMGetUserInfoSucc)succ fail:(SIMFail)fail;


/**
 *  设置自己的资料
 *
 *  @param values 需要更新的属性，可一次更新多个字段. 参见 SIMUserProfile 的 SIMUserInfoTypeKey_XXX
 *  @param succ 成功回调
 *  @param fail 失败回调
 *
 *  @return 0 发送请求成功
 */
- (int)modifySelfProfile:(NSDictionary *)values succ:(SIMSucc)succ fail:(SIMFail)fail;


#pragma mark - 账号管理

/**
 *  通过账号获取用户账号信息
 *
 *  @param identifier   应用账号唯一标识(1-32位)
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0 发送请求成功
 */
- (int)getUserProfile:(NSString *)identifier succ:(SIMGetUserInfoSucc)succ fail:(SIMFail)fail;


/**
 *  通过accounts集合获取用户账号信息
 *
 *  @param identifiers  用户id，非好友的用户也可以，逗号隔开
 *  @param succ         成功回调
 *  @param fail         失败回调
 *
 *  @return 0 发送请求成功
 */
- (int)getUsersProfile:(NSArray<NSString *> *)identifiers succ:(SIMGetUserInfoArraySucc)succ fail:(SIMFail)fail;


/**
 *  通过账号或昵称搜索用户(分页)
 *
 *  @param param    用户id，非好友的用户也可以
 *  @param page     页号(1-99999999), 默认为1
 *  @param size     每页行数(1-100), 默认为100
 *  @param succ     成功回调
 *  @param fail     失败回调
 *
 *  @return 0 发送请求成功
 */
- (int)getUsersProfile:(NSString *)param page:(NSInteger)page size:(NSInteger)size succ:(SIMGetUserInfoArraySucc)succ fail:(SIMFail)fail;


#pragma mark - 好友

/**
 *  获取好友列表
 *
 *  @param succ 成功回调，返回好友(TIMFriend)列表
 *  @param fail 失败回调
 *
 *  @return 0 发送请求成功
 */
- (int)getFriendListRequest:(SIMFriendListRequest *)request succ:(SIMGetFriendArraySucc)succ fail:(SIMFail)fail;


/**
 *  添加好友
 *
 *  @param request 添加好友请求
 *  @param succ  成功回调(TIMFriendResult)
 *  @param fail  失败回调
 *
 *  @return 0 发送请求成功
 */
- (int)addFriend:(SIMAddFriendRequest *)request succ:(SIMFriendResultSucc)succ fail:(SIMFail)fail;


/**
 *  删除好友
 *
 *  @param user 要删除的好友的 identifier
 *  @param delType 删除类型（单向好友、双向好友）
 *  @param succ  成功回调([TIMFriendResult])
 *  @param fail  失败回调
 *
 *  @return 0 发送请求成功
 */
- (int)delFriend:(NSString *)user delType:(SIMDelFriendType)delType succ:(SIMFriendResultArraySucc)succ fail:(SIMFail)fail;


/**
 *  响应对方好友邀请
 *
 *  @param response  响应请求
 *  @param succ      成功回调
 *  @param fail      失败回调
 *
 *  @return 0 发送请求成功
 */
- (int)doResponse:(SIMAckFriendRequest *)response succ:(SIMFriendResultSucc)succ fail:(SIMFail)fail;


/**
 *  获取未决列表
 *
 *  @param pendencyRequest  请求信息，详细参考 SIMFriendPendencyRequest
 *  @param succ 成功回调
 *  @param fail 失败回调
 *
 *  @return 0 发送请求成功
 */
- (int)getPendencyList:(SIMFriendPendencyRequest *)pendencyRequest succ:(SIMGetFriendPendencyListSucc)succ fail:(SIMFail)fail;


/**
 *  获取好友未读数量
 *
 *  @param succ 好友申请未读数回调
 *  @param fail 失败回调
 *  @return 0 发送请求成功
 */
- (int)getFriendApplyUnreadNumberWithSucc:(SIMGetFridenApplyUnReadSucc)succ fail:(SIMFail)fail;


/**
 *  设置申请好友记录已读
 
 *  @param succ 成功回调
 *  @param fail 失败回调
 *  @return 0 发送请求成功
 */
- (int)setFriendApplyReadSucc:(SIMSucc)succ fail:(SIMFail)fail;

@end

NS_ASSUME_NONNULL_END
