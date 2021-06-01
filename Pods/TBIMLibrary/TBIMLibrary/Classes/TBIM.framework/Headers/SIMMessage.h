//
//  NBMessage.h
//  NBIMDemo
//
//  on 2019/4/25.
//

#import "SIMBaseMessage.h"
#import "SIMComm+Message.h"
#import "SIMComm+Group.h"
#import "SIMComm+Session.h"
#import "SIMComm+Control.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 消息基类

@interface SIMElem : NSObject

/**
 *  扩展字段
 */
@property(nonatomic,strong) NSString *ext;

@end

#pragma mark - 文本消息

@interface SIMRedEnvelopesElem : SIMElem

@property(nonatomic, assign)BOOL isAt;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *redSender;
@property(nonatomic, copy)NSString *orderId;
/// 标记红包是否点击
@property (nonatomic, assign) int redDarkenFlag; // 0 正常状态 1 点击过 变暗状态
@end




/// 红包被领取通知 领完 过期
@interface SIMRedEnvelopesStatusElem : SIMElem

@property(nonatomic, copy)NSString *orderId;
@property(nonatomic, strong)NSArray *redSender;
@property(nonatomic, copy)NSString *opUserAccount; // 领取人账号
@property(nonatomic, copy)NSString *opUserName; // 领取红包的人名
@end

@interface SIMTextElem : SIMElem
/**
 *  消息文本
 */
@property(nonatomic,strong) NSString *text;

/**
 *  发送消息被@的账号
 */
@property (nonatomic, strong) NSArray *members;

/**
 *  收到消息，是否被发送者@了
 */
@property (nonatomic, assign) BOOL isAt;

@end

#pragma mark - 图片消息

/**
 *  图片
 */
@interface SIMImage : NSObject
/**
 *  图片类型
 */
@property(nonatomic,assign) SIMImageType type;
/**
 *  图片大小
 */
@property(nonatomic,assign) int size;
/**
 *  图片宽度
 */
@property(nonatomic,assign) int width;
/**
 *  图片高度
 */
@property(nonatomic,assign) int height;
/**
 *  下载URL
 */
@property(nonatomic, strong) NSString *url;

@end
/**
 *  图片消息Elem
 */
@interface SIMImageElem : SIMElem


/**
 *  所有类型图片，只读，发送的时候不用关注，接收的时候这个字段会保存图片的所有规格，目前最多包含三种规格：原图、大图、缩略图，每种规格保存在一个 SIMImage 对象中
 */
@property(nonatomic,strong) NSArray<SIMImage *> * imageList;

/**
 *  图片压缩等级，详见 TIM_IMAGE_COMPRESS_TYPE（仅对 jpg 格式有效）
 */
//@property(nonatomic,assign) SIM_IMAGE_COMPRESS_TYPE level;

/**
 *  图片格式，详见 TIM_IMAGE_FORMAT
 */
@property(nonatomic,assign) SIM_IMAGE_FORMAT format;

/**
 path、 upImage、 imageData三者选其一即可
 
 */

/**
 *  要发送的图片路径 注意是本地沙盒路径 不是相册中的路径
 */
@property(nonatomic,strong) NSString *path;
/**
 要发送的图片对象
 */
@property(nonatomic, strong)UIImage *upImage;
/**
 要发送的图片data
 */
@property(nonatomic, strong)NSData *imageData;

/// 是否发送原图
@property(nonatomic,assign) BOOL isHD;

@end

#pragma mark - 自定义表情消息

@interface SIMExpressionElem : SIMElem

/// 表情MD5
@property (nonatomic, strong) NSString * imgMd;

/// 表情地址
@property (nonatomic, strong) NSString * imgUrl;

/// 表情大小 单位:字节
@property (nonatomic, assign) long long  size;

/// 表情高度
@property (nonatomic, assign) CGFloat height;

/// 表情宽度
@property (nonatomic, assign) CGFloat width;

@end

#pragma mark - 语音消息

@interface SIMVoiceElem : SIMElem

/**
 音频上传路径
 */
@property (nonatomic,strong) NSString *path;

/**
 音频大小
 */
@property (nonatomic,assign) int size;

/**
 音频时长
 */
@property (nonatomic,assign) int duration;

/**
 音频URL
 */
@property (nonatomic,strong) NSString *downUrl;

/**
 音频格式
 */
@property (nonatomic,assign) SIMVoiceFormat format;

// 语音第一次发送的人
@property (nonatomic, copy)NSString *originSender;

/**
 下载语音

 @param path 本地地址
 @param succ 成功回调
 @param fail 失败回调
 */
- (void)getVoice:(NSString *)path succ:(SIMSucc)succ fail:(SIMFail)fail;

@end

#pragma mark - 视频消息

@interface SIMVideoElem : SIMElem
/**
 视频上传路径
 */
@property (nonatomic,strong) NSString *videoPath;

/**
 封面上传路径
 */
@property (nonatomic,strong) NSString *coverPath;

/**
 视频大小
 */
@property (nonatomic,assign) int videoSize;

/**
 视频Url
 */
@property (nonatomic,strong) NSString *videoUrl;

/**
 视频时长
 */
@property (nonatomic,assign) int duration;
/**
 视频格式
 */
@property (nonatomic,assign) SIMVideoFormat videoFormat;


/**
 图片URL
 */
@property (nonatomic,strong) NSString *coverUrl;

/**
 图片大小
 */
@property (nonatomic,assign) int coverSize;

/**
 图片高度
 */
@property (nonatomic,assign) int coverHeight;

/**
 图片宽度
 */
@property (nonatomic,assign) int coverWidth;

/**
 封面格式
 */
@property (nonatomic,assign) SIM_IMAGE_FORMAT coverFormat;

/**
 下载封面
 
 @param path 本地地址
 @param succ 成功回调
 @param fail 失败回调
 */
- (void)getCover:(NSString *)path succ:(SIMSucc)succ fail:(SIMFail)fail;

/**
 下载视频
 
 @param path 本地地址
 @param succ 成功回调
 @param fail 失败回调
 */
- (void)getVideo:(NSString *)path succ:(SIMSucc)succ fail:(SIMFail)fail;

@end

#pragma mark - 文件消息

@interface SIMFileElem : SIMElem
/**
 文件上传地址
 */
@property(nonatomic,strong) NSString *path;

/**
 文件大小
 */
@property(nonatomic,assign) int size;

/**
 文件m名称
 */
@property(nonatomic,strong) NSString *filename;

/**
 文件url
 */
@property(nonatomic,strong) NSString *downUrl;

/**
 文件格式
 */
@property(nonatomic,assign) SIMFileFormat format;

/**
 下载文件
 
 @param path 本地地址
 @param succ 成功回调
 @param fail 失败回调
 */
- (void)getFile:(NSString *)path succ:(SIMSucc)succ fail:(SIMFail)fail;

@end

#pragma mark - 已读

/// 设置已读请求对象
@interface SIMReadReqElem : SIMElem

/**
 设置已读消息的消息ID组,多个消息PacketId用,分隔
 */
@property (nonatomic,strong) NSString *messageId;

@end


/// 已读通知消息
@interface SIMReadElem : SIMElem

/**
 已读消息ID
 */
@property (nonatomic,strong) NSString *messageId;

@end


/// 主动获取消息已读通知对象
@interface SIMGetReadReqElem : SIMElem

/**
 消息ID
 */
@property (nonatomic,strong) NSString *messageId;

@end


#pragma mark - 撤回消息

@interface SIMRevokeElem : SIMElem

/**
 撤回ID
 */
@property (nonatomic,strong) NSString *messageId;

/**
 接收方
 */
@property (nonatomic,strong) NSString *receiver;

/**
 撤回人员
 */
@property (nonatomic,strong) NSString *revoker;

@end

#pragma mark - 删除消息

@interface SIMDeleteElem : SIMElem

/**
 删除的消息ID
 */
@property (nonatomic,strong) NSString *messageId;

/**
 会话Id
 */
@property (nonatomic,strong) NSString *receiver;

/**
 删除人
 */
@property (nonatomic,strong) NSString *deleter;

@end

#pragma mark - 设置红包变暗

@interface SIMRedEnvelopeClicked : SIMElem

@property (nonatomic,strong) NSString *messageId;
@end

#pragma mark - 标记消息

@interface SIMSignElem : SIMElem

/**
 标记的消息ID
 */
@property (nonatomic,strong) NSString *messageId;

/**
 会话Id
 */
@property (nonatomic,strong) NSString *receiver;

/**
 标记人员
 */
@property (nonatomic,strong) NSString *signUser;

@end

#pragma mark - 删除消息

@interface SIMCombineElem : SIMElem

/**
 标题
 */
@property (nonatomic,strong) NSString *title;

/**
 摘要
 */
@property (nonatomic,strong) NSString *content;

/**
 消息id数组
 */
@property (nonatomic,strong) NSArray<NSString *> *ids;

/**
 通话类型
 */
@property (nonatomic, assign) SIMSessionType chatType;

@property (nonatomic,copy) NSString *dmSource;
@end

#pragma mark - 信令消息

@interface SIMCMDElem : SIMElem

/**
 自定义数据
 */
@property (nonatomic,strong) NSString *data;

/**
 服务器是否持久化
 */
@property (nonatomic,assign) BOOL isSave;

/**
 是否需要离线推送
 */
@property (nonatomic,assign) BOOL isOfflinePush;

@end

#pragma mark - 自定义消息

@interface SIMCustomElem : SIMElem

/**
 自定义数据
 */
@property (nonatomic,strong) NSString *data;

@end

#pragma mark - 群通知消息

// 群组通知人员类型
@interface SIMGroupTipsForMember : NSObject
// 姓名
@property(nonatomic,strong) NSString *name;
// 账号
@property(nonatomic,strong) NSString *account;

@end

@interface SIMGroupTipsElem : SIMElem

// 执行人账号
@property(nonatomic,strong) NSString *opUserAccount;
// 执行人姓名
@property(nonatomic,strong) NSString *opUserName;
// 群组id
@property(nonatomic,strong) NSString *groupId;
// 群组名称
@property(nonatomic,strong) NSString *groupName;
// 是否同意
@property(nonatomic,strong) NSString *applyId;
// 申请原因
@property(nonatomic,strong) NSString *reason;
// 是否同意
@property(nonatomic,assign) BOOL agree;
// 人员列表
@property(nonatomic,strong) NSArray<SIMGroupTipsForMember *> *members;
// 加入方式，0-申请，1-邀请，3-群二维码入群，4-后台操作入群（目前仅针对组织群）
@property(nonatomic,assign) int joinType;
// 创建方式，0-普通群，1-后台创建组织群
@property(nonatomic,assign) int createType;
// 退群方式，0-前台操作，1-后台操作
@property(nonatomic,assign) int quitType;
// 0群主，1管理员，2普通用户
@property(nonatomic,assign) SIMGroupMemberRole role;
// 群公告
@property(nonatomic,strong) NSString *notice;
// 群头像
@property(nonatomic,strong) NSString *avatar;
// 设置申请加入群组是否需要审核（1需要审核，0不需要审核）
@property(nonatomic,strong) NSString *isReview;
// 群组被修改详细参数Keys
@property(nonatomic,strong) NSArray *groupDetailChangedKeys;
// 是否是人为修改 0:非人为修改 1:人为修改
@property(nonatomic,assign) int isHuman;
// //数组里边存在一个或者多个值，0群名修改， 1群公告修改， 2群头像修改
@property(nonatomic,strong) NSArray *modifyParam;
/// 1表示开，0表示关
@property(nonatomic,assign) int toggle;

/// 禁言部分新加 禁言或者解除禁言的人员
@property(nonatomic, copy)NSString *userNames;
@property(nonatomic, strong)NSArray *userIds;
@property(nonatomic, assign)long forbidTime;
@property(nonatomic, assign)long long forbidStartTime;
@property(nonatomic, assign)long long systemTime;
@end

#pragma mark - 群公告

@interface SIMEventDescElem : SIMElem

// 执行人账号
@property(nonatomic,copy) NSString *opUserAccount;
// 执行人姓名
@property(nonatomic,copy) NSString *opUserName;
// 群组id
@property(nonatomic,copy) NSString *groupId;
// 群组名称
@property(nonatomic,copy) NSString *groupName;
// 说明文字
@property(nonatomic,copy) NSString *text;
// 说明附件信息
@property(nonatomic,strong) NSString *fileInfo;
// 说明图片信息
@property(nonatomic,strong) NSString *imageInfo;
// 说明附件信息
@property(nonatomic,strong) NSArray<SIMFileElem *> *fileInfoArray;
// 说明图片信息
@property(nonatomic,strong) NSArray<SIMImageElem *> *imageInfoArray;
// 说明ID
@property(nonatomic,copy) NSString *explainId;
// 是否@所有人
@property(nonatomic,assign) int isAt;

@end

#pragma mark - 引用回复数量通知消息

@interface SIMReplyElem : SIMElem

/**
 通知消息ID
 */
@property (nonatomic,strong) NSString *messageId;

/**
 会话ID
 */
@property (nonatomic,strong) NSString *sessionId;

/**
 回复者
 */
@property (nonatomic,strong) NSString *replyer;

/**
 回复数量
 */
@property (nonatomic, assign) int replyCount;

@end

#pragma mark - 基础消息的公共属性
// 回复消息字段
@interface SIMReply : NSObject
// 祖先
@property(nonatomic,strong) NSString *ancestor;
// 回复的那条消息id
@property(nonatomic,strong) NSString *replyId;
// 摘要
@property(nonatomic,strong) NSString *abstract;
@end

// 公共属性
@interface SIMDomain : NSObject
// 回复
@property(nonatomic,strong) SIMReply *reply;
// 简评（后续可能需要）
@property(nonatomic,strong) NSString *evaluate;
@end

#pragma mark - 普通消息体

@interface SIMMessage : SIMBaseMessage

/**
 基础消息的公共属性(字符串格式，用于网络传输<它方要求，非最好方案>)
 */
@property (nonatomic, strong) NSString *domain;

/**
 基础消息的公共属性（domain只要赋值，如代码直接赋值或者YYmodel模型转换，都会直接同步到domainModel）
 */
@property (nonatomic, strong) SIMDomain *domainModel;

/**
 内容，c=0时为心跳id，c=20时为消息正文
 */
@property (nonatomic, copy) NSString *message;

/**
 消息类型，0-文本，1-语音，2-图片，3-视频，4-文件，5-已读，6-撤回
 */
@property (nonatomic, assign) SIMMsgType msgType;

/**
 消息体
 */
@property (nonatomic, strong) SIMElem *elem;

/**
 消息发送时间戳
 */
@property (nonatomic, assign) long long time;

/**
 发送者账号
 */
@property (nonatomic, copy) NSString *sender;

/**
 发送者昵称
 */
@property (nonatomic, copy) NSString *senderName;

/**
 接收方
 */
@property (nonatomic, copy) NSString *receiver;

/**
 聊天室类型，0-单聊，1-群聊
 */
@property (nonatomic, assign) SIMSessionType chatType;

/**
 聊天类型 0-普通 1-密聊 2-团队聊天 3-不能聊天
 */
@property (nonatomic, assign) SIMSecType securityType;

/**
 扩展
 */
@property (nonatomic, strong) NSDictionary *remarks;


/**
 是否标记,false未标记 ，true已标记 ,
 */
@property (nonatomic, assign) BOOL sign;

/**
 标记人账号
 */
@property (nonatomic, copy) NSString *signUser;

/**
 标记人昵称
 */
@property (nonatomic, copy) NSString *signUserName;

/**
 标记时间
 */
@property (nonatomic, copy) NSString *signDate;

/**
 消息是否需要未读计数，0消息需要计数，1消息不需要计数
 */
@property (nonatomic, assign) int varStatus;

/**
 撤回状态，false 未撤回，1已撤回
 */
@property (nonatomic, assign) int delFlag;

/**
 消息引用回复数量
 */
@property (nonatomic, assign) int replyCount;

/**
 是否离线推送（true表示推送，false表示不推送）
 */
@property (nonatomic, assign) int offlinePush;

/**
 "{ \"title\":\"消息标题\"，\"content\":"消息内容"}"
 */
@property (nonatomic, copy) NSString *offlinePushInfo;

/// 是否已读
@property (nonatomic, assign) BOOL readed;

/// 已读人数
@property (nonatomic, assign) int pReaded;

/// 所有应读人数
@property (nonatomic, assign) int pAll;

@property (nonatomic,copy) NSString *tId; //最后一条消息的后台ID

/// 连续标志，0表示不连续，1表示连续，（本地使用，）
@property (nonatomic, assign) int serialSign;

/// 是否已删除
@property (nonatomic, assign) BOOL priDelFlag;

/// NO表示不是外域，YES表示为跨域
@property (nonatomic,assign) BOOL cross;

/// 群组类型-因为后台原因，目前仅仅添加此参数用于判断消息是否来自会议讨论组
@property (nonatomic, assign) SIMGroupType groupType;


- (instancetype)initWithReceiver:(NSString *)receiver chatType:(SIMSessionType)chatType;

/**
 获取当前消息的会话Id

 @return 会话Id
 */
- (NSString *)getSessionId;

@end

NS_ASSUME_NONNULL_END
