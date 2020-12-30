//
//  SIMComm+Message.h
//  NBIMDemo
//
//  Created by 王杰 on 2019/6/4.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import "SIMComm.h"
//#import "SIMComm+Session.h"

NS_ASSUME_NONNULL_BEGIN

@class SIMMessage;

#pragma mark - 枚举类型

/**
 *  消息类型
 */
typedef NS_ENUM(NSInteger, SIMMsgType){
    SIMMsgType_TXT = 0, //  文本消息
    SIMMsgType_IMAGE = 1,   //  图片消息
    SIMMsgType_VOICE = 2,   //  语音消息
    SIMMsgType_VIDEO = 3,   //  视频消息
    SIMMsgType_FILE = 4,   //  文件消息
    SIMMsgType_READ = 5,   //  已读
    SIMMsgType_REVOKE = 6,   //  撤回
    SIMMsgType_DELETE = 7,   //  删除
    SIMMsgType_COMBINE = 8,   //  合并转发
    SIMMsgType_CUSTOMEMOJI = 11, //自定义表情
    SIMMsgType_CMD = 500,   //  信令消息
    SIMMsgType_CUSTOM = 10000,   //  自定义消息
    SIMMsgType_GROUP_CREATE = 20000,   //  建群通知
    SIMMsgType_GROUP_JOIN = 20001,   //  入群通知
    SIMMsgType_GROUP_QUIT = 20002,   //  退群通知
    SIMMsgType_GROUP_REMOVE_MEMBER = 20003,   //  移除人员通知
    SIMMsgType_GROUP_CHANGE_ROLE = 20005,   //  修改群成员角色
    SIMMsgType_GROUP_MODIFY_GROUPINFO = 20006,   //  设置群组详情
    SIMMsgType_GROUP_EVENT_DESC = 20007,    // 群公告
    SIMMsgType_SYSTEM_TOGGLE_INVITE = 20008, // 普通群成员邀请开关通知
    SIMMsgType_SYSTEM_TOGGLE_ATALL = 20009, // 普通群成员@ALL开关通知
    SIMMsgType_SYSTEM_REMOVED = 30001,   //  被踢出
    SIMMsgType_SYSTEM_DISBAND_GROUP = 30002,   //  群解散
    SIMMsgType_SYSTEM_QUIT_SELF = 30003,   //  自己退群通知
};

/**
 *  会话类型
 */
typedef NS_ENUM(NSInteger, SIMSessionType){
    /**
     *  单聊
     */
    SIMSessionType_P2P = 0,
    /**
     *  群聊
     */
    SIMSessionType_GROUP = 1,
    /**
     *  订阅号
     */
    SIMSessionType_SUBSCRIBE = 2,
    /**
     *  订阅号盒子
     */
    SIMSessionType_SUBSCRIBEBOX = 10,
};

/**
 会话消息拉取方向类型
 */
typedef NS_ENUM(NSInteger, SIMMessagePullType){
    SIMMessagePullType_Old = 0,  //向下拉
    SIMMessagePullType_New = 1,  //向上拉
    SIMMessagePullType_OldAndNew = 2,  //定位前后
};


/**
 *  图片类型
 */
typedef NS_ENUM(NSInteger, SIMImageType){
    /**
     *  原图
     */
    SIMImageType_Original = 0,
    /**
     *  大图
     */
    SIMImageType_Large  = 1,
    /**
     *  缩略图
     */
    SIMImageType_Thumb  = 2,
};

/**
 *  图片格式
 */
typedef NS_ENUM(NSInteger, SIM_IMAGE_FORMAT){
    /**
     *  JPG 格式
     */
    SIM_IMAGE_FORMAT_JPG            = 0,
    /**
     *  PNG 格式
     */
    SIM_IMAGE_FORMAT_PNG            = 1,
    /**
     *  未知格式
     */
    SIM_IMAGE_FORMAT_UNKNOWN        = 255,
};

/**
 *  图片压缩选项
 */
typedef NS_ENUM(NSInteger, SIM_IMAGE_COMPRESS_TYPE){
    /**
     *  原图(不压缩）
     */
    SIM_IMAGE_COMPRESS_ORIGIN              = 0,
    /**
     *  高压缩率：图片较小，默认值
     */
    SIM_IMAGE_COMPRESS_HIGH                = 1,
    /**
     *  低压缩：高清图发送(图片较大)
     */
    SIM_IMAGE_COMPRESS_LOW                 = 2,
};



/**
 *  音频格式
 *
 *  - SIMVoiceFormat_AMR: amr
 *  - SIMVoiceFormat_MP3: mp3
 *  - SIMVoiceFormat_UNKNOWN: 未知格式
 */
typedef NS_ENUM(NSInteger, SIMVoiceFormat) {
    SIMVoiceFormat_AMR = 0,
    SIMVoiceFormat_MP3 = 1,
    SIMVoiceFormat_UNKNOWN = 255
};

typedef NS_ENUM(NSInteger, SIMFileFormat) {
    SIMFileFormat_TXT  =  0,
    SIMFileFormat_WORD  =  1,
    SIMFileFormat_EXCEL =  2,
    SIMFileFormat_JPEG  =  3,
    SIMFileFormat_PDF  =  4,
    SIMFileFormat_PPT  =  5,
    SIMFileFormat_RAR  =  6,
    SIMFileFormat_HTML = 7,
    SIMFileFormat_MP4 = 8,
    SIMFileFormat_MP3 = 9,
    SIMFileFormat_MIND = 10,
    SIMFileFormat_AI = 11,
    SIMFileFormat_PSD = 12,
    SIMFileFormat_UNKNOWN  =  225
};

typedef NS_ENUM(NSInteger, SIMVideoFormat) {
    SIMVideoFormat_AVI = 0,
    SIMVideoFormat_RM = 1,
    SIMVideoFormat_RMVB = 2,
    SIMVideoFormat_WMV = 3,
    SIMVideoFormat_MP4 = 4,
    SIMVideoFormat_MOV = 5,
    SIMVideoFormat_UNKNOWN = 255,
};

typedef NS_ENUM(NSInteger, SIMRecentQueryType) {
    //单聊 消息
    SIMRecentQueryType_SINGLE = 0,
    //群聊 消息
    SIMRecentQueryType_GROUP = 1,
    //指令 消息
    SIMRecentQueryType_CMD = 2
};


#pragma mark - block 回调

/**
 *  拉取普通历史消息成功回调
 */
typedef void (^SIMOfflineMsgReqSucc)(NSArray<SIMMessage *> *msgs);

/**
 *  拉取普通历史消息和信令消息成功回调
 */
typedef void (^SIMOfflineAllMsgReqSucc)(NSArray<SIMMessage *> *msgs, NSArray<SIMMessage *> *cmdMsgs);

/**
 *  拉取单条消息成功回调
 */
typedef void (^SIMMsgReqSucc)(SIMMessage *msg);

/**
 *  搜索普通历史消息成功回调
 */
typedef void (^SIMSearchMsgReqSucc)(NSArray<SIMMessage *> *msgs);


#pragma mark - 基础类型

/**
 *  离线消息拉取
 */
@interface SIMOfflineMsgReq : NSObject

/**
 *  单聊传接收方账号，群聊传群 id (1-32 位)
 */
@property(nonatomic,strong) NSString *sessionId;

/**
 *  类型 0 单聊，1 群聊
 */
@property(nonatomic,assign) NSInteger sessionType;

/**
 *  安全类型，0 普通，1 密聊
 */
@property(nonatomic,assign) NSInteger securityType;

/**
 *  开始 msId
 */
@property(nonatomic,strong) NSString *msgId;

/**
 *  获取数量
 */
@property(nonatomic,assign) NSInteger rows;

/**
 *  类型 0向下拉，1向上拉，2定位前后
 */
@property(nonatomic,assign) NSInteger type;

@end


/**
 *  离线消息拉取（包括指令）
 */
@interface SIMOfflineAllMsgReq : NSObject

/**
 *  单聊传接收方账号，群聊传群 id (1-32 位)
 */
@property(nonatomic,strong) NSString *sessionId;

/**
 *  类型 0 单聊，1 群聊
 */
@property(nonatomic,assign) NSInteger sessionType;

/**
 *  安全类型，0 普通，1 密聊
 */
@property(nonatomic,assign) NSInteger securityType;

/**
 *  开始 msId
 */
@property(nonatomic,strong) NSString *msgId;

/**
 *  获取数量
 */
@property(nonatomic,assign) NSInteger rows;

/**
 *  类型 0向下拉，1向上拉，2定位前后
 */
@property(nonatomic,assign) NSInteger type;

@end


@interface SIMComm (Message)

@end


@interface SIMRecentMsgRequest : NSObject

/**
 *  最新消息时间戳
 */
@property(nonatomic,assign) long lastMsgTime;

/**
 *  最后一条消息的后台ID
 */
@property(nonatomic,copy) NSString *tId;

/**
 *  登录时间戳
 */
@property(nonatomic,assign) long loginTime;

/**
 *  搜索类型
 */
@property(nonatomic,assign) SIMRecentQueryType queryType;

@end


@interface SIMSignRequest : NSObject

/**
 *  被操作消息ID
 */
@property(nonatomic,copy) NSString *msgId;

/**
 *  会话ID
 */
@property(nonatomic,copy) NSString *sessionId;

/**
 *  安全类型 SIMSecType类型
 */
@property(nonatomic,assign) int securityType;

/**
 *  安全类型 SIMSessionType类型
 */
@property(nonatomic,assign) int sessionType;

/**
 *  true为标记请求，false为取消标记请求
 */
@property(nonatomic,assign) BOOL sign;

/**
 *  获取数量
 */
@property(nonatomic,assign) NSInteger rows;

/**
 *  标记时间戳
 */
@property(nonatomic,assign) long signDate;

/**
 *  0表示不是外域，1表示为跨域
 */
@property(nonatomic,assign) NSInteger cross;

@end


@interface SIMSearchMsgRequest : NSObject

/**
 *  被操作消息ID
 */
@property(nonatomic,copy) NSString *msgId;

/**
 *  会话ID
 */
@property(nonatomic,copy) NSString *sessionId;

/**
 *  安全类型 SIMSecType类型
 */
@property(nonatomic,assign) int securityType;

/**
 *  聊天类型 SIMSessionType类型
 */
@property(nonatomic,assign) int sessionType;

/**
 *  0 全部 ,1 文件 ,2 图片及视频
 */
@property(nonatomic,assign) int type;

/**
 *  获取数量
 */
@property(nonatomic,assign) NSInteger rows;

/**
 *  搜索字段
 */
@property(nonatomic,copy) NSString *searchName;

@end


NS_ASSUME_NONNULL_END
