//
//  SIMComm.h
//  NBIMDemo
//
//  Created by 一个工匠 on 2019/6/1.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMError.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SIMConnListener;

#pragma mark - 枚举类型

/**
 *  Client和Server对接Command
 */
typedef NS_ENUM(NSInteger, SIMCommandType){
    // 通用
    SIMCommandType_keep_alive = 0,                                  ///< 心跳
    SIMCommandType_login = 1,                                       ///< 登陆
    SIMCommandType_logout = 2,                                      ///< 登出
    SIMCommandType_noti_online = 3,                                 ///< 上线通知
    SIMCommandType_noti_offline = 4,                                ///< 下线通知
    SIMCommandType_noti_kicked_offline = 5,                         ///< 被踢下线通知
    SIMCommandType_noti_kicked_out_offline = 6,                     ///< 踢用户其他在线终端
    SIMCommandType_upload_device_detail = 7,                        ///< 上传终端设备信息
    SIMCommandType_noti_offline_new = 8,                            ///< 下线通知-汇总，TYPE为下线类型，0【原4】为主动下线，1【原5】为被挤下线，2【原6】为自己踢自己下线，3为修改密码被下线，4为账号被禁用下线通知
    SIMCommandType_message = 20,                                    ///< 消息
    SIMCommandType_server_ack = 21,                                 ///< 服务端回执
    SIMCommandType_client_ack = 22,                                 ///< 客户端回执
    SIMCommandType_message_read = 23,                               ///< 设置消息已读
    SIMCommandType_message_revoke = 24,                             ///< 撤回消息
    SIMCommandType_message_delete_member = 25,                      ///< 用户删除消息（自己删除，已接收用户仍可见）
    SIMCommandType_message_delete_group_owner = 26,                 ///< 群管理员删除消息（管理员删除，所有群成员均不可见）
    SIMCommandType_message_mark = 27,                               ///< 标记消息（对事件群消息的标记）
    SIMCommandType_message_mark_cancel = 28,                        ///< 取消标记消息（对事件群消息的标记）
    SIMCommandType_video_audio = 29,                                ///< 音视频
    SIMCommandType_message_offline = 30,                            ///< 查询离线消息
    SIMCommandType_message_offline_ack = 31,                        ///< 返回查询离线消息
    SIMCommandType_message_doBackground = 32,                       ///< APP进入前后台消息
    SIMCommandType_message_noti_replycount = 33,                    ///< 消息引用回复的数量
    SIMCommandType_message_hadRead = 34,                            ///< 消息已读通知（服务端发给消息发送者）
    SIMCommandType_message_getHadRead = 35,                         ///< 主动获取消息已读通知
    // 会话相关
    SIMCommandType_session_list = 50,                               ///< 获取会话列表
    SIMCommandType_session_create = 51,                             ///< 会话创建通知（加好友，加群等给自己三端同步）
    SIMCommandType_session_disturb = 52,                            ///< 会话免打扰设置
    SIMCommandType_session_noti_disturb = 53,                       ///< 会话免打扰设置通知
    SIMCommandType_session_unread_count_reset = 54,                 ///< 会话消息计数重置
    SIMCommandType_session_noti_unread_count_reset = 55,            ///< 会话消息计数重置通知
    SIMCommandType_session_top_list = 56,                           ///< 获取置顶列表
    SIMCommandType_session_top = 57,                                ///< 会话置顶设置
    SIMCommandType_session_noti_top = 58,                           ///< 会话置顶设置通知
    SIMCommandType_session_noti_delete = 59,                        ///< 设置会话不可见通知（删除会话）
    SIMCommandType_session_update_name = 60,                        ///< 会话名称修改设置
    SIMCommandType_session_noti_update_name = 61,                   ///< 会话名称修改设置通知
    // 自定义消息
    SIMCommandType_message_custom = 99,                             ///< 自定义消息
    // 账号和好友关系
    SIMCommandType_account_update = 100,                            ///< 修改账号信息
    SIMCommandType_noti_account_update = 101,                       ///< 修改账号信息通知(三端同步)
//    SIMCommandType_ = 102,///< 人员搜索
//    SIMCommandType_ = 103,///< 获取人员信息
//    SIMCommandType_ = 104,///< 获取好友列表
//    SIMCommandType_ = 105,///< 获取好友信息
//    SIMCommandType_ = 106,///< 好友申请列表
//    SIMCommandType_ = 107,///< 好友申请
    SIMCommandType_friend_noti_apply = 108,                         ///< 好友申请通知（向被申请方发送好友申请通知）
    SIMCommandType_firend_reply = 109,                              ///< 答复好友申请（被添加通知）
    SIMCommandType_friend_noti_reply = 110,                         ///< 答复好友申请通知（给申请方发送答复通知）
    SIMCommandType_friend_delete = 111,                             ///< 删除好友
    SIMCommandType_friend_noti_delete = 112,                        ///< 删除好友通知
    SIMCommandType_friend_noti_remark = 113,                        ///< 好友标注修改通知
    // 群组相关
//    SIMCommandType_ = 200,///< 创建群组
//    SIMCommandType_ = 201,///< 申请加入群组
//    SIMCommandType_ = 202,///< 申请加入群组通知
//    SIMCommandType_ = 203,///< 答复入群申请
//    SIMCommandType_ = 204,///< 入群申请结果通知
//    SIMCommandType_ = 205,///< 成员入群通知
//    SIMCommandType_ = 206,///< 邀请加入群组
//    SIMCommandType_ = 207,///< 邀请加入群组通知
//    SIMCommandType_ = 208,///< 答复入群邀请
//    SIMCommandType_ = 209,///< 入群邀请答复通知
//    SIMCommandType_ = 210,///< 退出群组
//    SIMCommandType_ = 211,///< 退出群组通知
//    SIMCommandType_ = 212,///< 踢人
//    SIMCommandType_ = 213,///< 移除人员通知
//    SIMCommandType_ = 214,///< 解散群组
//    SIMCommandType_ = 215,///< 解散群组通知
//    SIMCommandType_ = 216,///< 获取群组成员
//    SIMCommandType_ = 217,///< 群组搜索
//    SIMCommandType_ = 218,///< 获取个人所在群组
//    SIMCommandType_ = 219,///< 修改群成员角色
//    SIMCommandType_ = 220,///< 群成员禁言
//    SIMCommandType_ = 221,///< 获取群成员名片
//    SIMCommandType_ = 222,///< 设置群成员名片
//    SIMCommandType_ = 223,///< 获取群组详情
//    SIMCommandType_ = 224,///< 设置群组详情
};

#pragma mark - Block 回调
/**
 *  一般操作成功回调
 */
typedef void (^SIMSucc)(void);

/**
 *  带有返回数据的操作成功回调
 */
typedef void (^SIMSuccData)(id data);

/**
 *  操作失败回调
 *
 *  @param error 自定义错误错误码
 */
typedef void (^SIMFail)(SIMError * __nullable error);

/**
 *  文件上传成功回调
 *  @param remoteURL    生成的文件远程URL
 */
typedef void (^SIMUploadSucc)(NSString *remoteURL);

/**
 *  文件下载成功回调
 *  @param data 下载的NSData数据
 */
typedef void (^SIMDownloadSucc)(NSData *data);

/**
 *  文件上传或下载进度回调
 *
 *  @param curSize      已上传或下载大小
 *  @param totalSize    总大小
 */
typedef void (^SIMProgress)(NSInteger curSize, NSInteger totalSize);


#pragma mark - 基本类型

@interface SIMComm : NSObject

@end

NS_ASSUME_NONNULL_END
