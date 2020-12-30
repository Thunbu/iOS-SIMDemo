//
//  SIMFriend.h
//  NBIMDemo
//
//  Created by 王杰 on 2019/5/27.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMComm+Friend.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  个人信息类
 */
@interface SIMUserProfile : NSObject

/**
 *  用户 identifier
 */
@property(nonatomic,strong) NSString* identifier;

/**
 *  用户昵称
 */
@property(nonatomic,strong) NSString* nickname;

/**
 *  好友验证方式
 */
@property(nonatomic,assign) SIMFriendAllowType allowType;

/**
 * 用户头像
 */
@property(nonatomic,strong) NSString* faceURL;

/**
 *  用户签名
 */
@property(nonatomic,strong) NSString* selfSignature;

/**
 *  用户性别
 */
@property(nonatomic,assign) SIMGender gender;

/**
 *  用户生日
 */
@property(nonatomic,assign) uint32_t birthday;

/**
 *  用户区域
 */
@property(nonatomic,strong) NSString* location;

/**
 *  用户语言
 */
@property(nonatomic,assign) uint32_t language;

/**
 *  等级
 */
@property(nonatomic,assign) uint32_t level;

/**
 *  角色
 */
@property(nonatomic,assign) uint32_t role;

/**
 *  名称拼音
 */
@property(nonatomic,strong) NSString* namePY;

/**
 *  自定义字段集合,key是NSString类型,value是NSData类型或者NSNumber类型
 *  key值按照后台配置的字符串传入,不包括 SIMProfileTypeKey_Custom_Prefix 前缀
 */
@property(nonatomic,strong,readonly) NSDictionary* customInfo;

@property(nonatomic,strong,readonly) NSString * definition;

@property(nonatomic,strong) NSString * mPhone;

@end


/////////////////////////////////////////////////////////////////////////////////
//
//                      （一）好友类 Model
//
/////////////////////////////////////////////////////////////////////////////////

@interface SIMFriend : NSObject

/**
 *  好友identifier
 */
@property(nonatomic,strong) NSString *identifier;

/**
 *  好友备注（最大96字节，获取自己资料时，该字段为空）
 */
@property(nonatomic,strong) NSString *remark;

/**
 *  申请时的添加理由
 */
@property(nonatomic,strong) NSString *addWording;

/**
 *  申请时的添加来源
 */
@property(nonatomic,strong) NSString *addSource;

/**
 * 添加时间
 */
@property(nonatomic,assign) uint64_t addTime;

/**
 *  自定义字段集合,key是NSString类型,value是NSData类型或者NSNumber类型
 *  key值按照后台配置的字符串传入,不包括 SIMFriendTypeKey_Custom_Prefix 前缀
 */
@property(nonatomic,strong) NSDictionary* customInfo;

/**
 * 好友资料
 */
@property(nonatomic,strong) SIMUserProfile *userInfo;

@end


/////////////////////////////////////////////////////////////////////////////////
//
//                      （二）一般响应 Model
//
/////////////////////////////////////////////////////////////////////////////////


/**
 *  返回结果
 */
@interface SIMFriendResult : NSObject
/**
 *  用户Id
 */
@property NSString* identifier;

/**
 * 返回码
 */
@property NSInteger result_code;

/**
 * 返回信息
 */
@property NSString *result_info;

@end



/////////////////////////////////////////////////////////////////////////////////
//
//                      （三）添加好友请求 Model
//
/////////////////////////////////////////////////////////////////////////////////

/**
 *  加好友请求
 */
@interface SIMAddFriendRequest : NSObject

/**
 *  用户identifier（必填）
 */
@property (nonatomic,strong) NSString* identifier;

/**
 *  备注（备注最大96字节）
 */
@property (nonatomic,strong) NSString* remark;

/**
 *  请求说明（最大120字节）
 */
@property (nonatomic,strong) NSString* addWording;

/**
 *  添加来源
 *  来源需要添加“AddSource_Type_”前缀
 */
@property (nonatomic,strong) NSString* addSource;

@end


/////////////////////////////////////////////////////////////////////////////////
//
//                      （四）同意/拒绝好友请求 Model
//
/////////////////////////////////////////////////////////////////////////////////

/**
 * 响应好友请求
 */
@interface SIMAckFriendRequest : NSObject

/**
 *  响应类型
 */
@property(nonatomic,assign) SIMFriendResponseType responseType;

/**
 *  用户identifier
 */
@property(nonatomic,strong) NSString* identifier;

/**
 *  备注好友（可选，如果要加对方为好友）。备注最大96字节
 */
@property(nonatomic,strong) NSString* remark;

/**
 *  理由
 */
@property(nonatomic,strong) NSString * reason;

@end

/////////////////////////////////////////////////////////////////////////////////
//
//                      删除好友请求 Model
//
/////////////////////////////////////////////////////////////////////////////////
@interface SIMDelFriendRequest : NSObject

@property (nonatomic,strong) NSString * identifier;

@property (nonatomic,assign) SIMDelFriendType type;

@end


/////////////////////////////////////////////////////////////////////////////////
//
//                      （五）未决列表List Model
//
/////////////////////////////////////////////////////////////////////////////////

/**
 * 未决请求
 */
@interface SIMFriendPendencyItem : NSObject

/**
 * 用户标识
 */
@property(nonatomic,strong) NSString* identifier;
/**
 * 增加时间
 */
@property(nonatomic,assign) uint64_t addTime;
/**
 * 来源
 */
@property(nonatomic,strong) NSString* addSource;
/**
 * 加好友附言
 */
@property(nonatomic,strong) NSString* addWording;

/**
 * 加好友昵称
 */
@property(nonatomic,strong) NSString* nickname;

/**
 * 未决请求类型
 */
@property(nonatomic,assign) SIMPendencyType type;

/**
 *  操作类型
 */
@property(nonatomic,assign) SIMFriendPendencyItemType reqAck;

@end


/////////////////////////////////////////////////////////////////////////////////
//
//                      （六）好友列表请求 Model
//
/////////////////////////////////////////////////////////////////////////////////


/**
 *  获取好友列表请求
 */
@interface SIMFriendListRequest : NSObject
/**
 *  请求页数
 */
@property(nonatomic,assign) NSInteger page;
/**
 *  每页数量
 */
@property(nonatomic,assign) NSInteger size;

@end

/////////////////////////////////////////////////////////////////////////////////
//
//                      （七）好友列表响应 Model
//
/////////////////////////////////////////////////////////////////////////////////

/**
 *  获取好友列表 响应
 */
@interface SIMFriendListResponse : NSObject

/**
 *  当前页
 */
@property(nonatomic,assign) NSInteger page;

/**
 *  每页数量
 */
@property(nonatomic,assign) NSInteger pageSize;

/**
 *  拉取到的数量
 */
@property(nonatomic,assign) NSInteger size;

/**
 *  好友列表List
 */
@property(nonatomic,strong) NSArray<SIMFriend * > * friends;

@end


/////////////////////////////////////////////////////////////////////////////////
//
//                      （八）未决列表请求 Model
//
/////////////////////////////////////////////////////////////////////////////////

/**
 * 未决请求信息
 */
@interface SIMFriendPendencyRequest : NSObject


@property(nonatomic,assign) NSInteger page;

@property (nonatomic,assign) NSInteger size;

/**
 * 未决请求拉取类型
 */
@property(nonatomic,assign) SIMPendencyType type;

@end

/////////////////////////////////////////////////////////////////////////////////
//
//                      （九）未决列表响应 Model
//
/////////////////////////////////////////////////////////////////////////////////

/**
 * 未决返回信息 响应
 */
@interface SIMFriendPendencyResponse : NSObject

/**
 *  当前页
 */
@property (nonatomic,assign) NSInteger page;

/**
 *  每页条数
 */
@property (nonatomic,assign) NSInteger pageSize;

/**
 *  拉取到的数量
 */
@property (nonatomic,assign) NSInteger size;

/**
 * 未决数据List
 */
@property NSArray<SIMFriendPendencyItem *> * pendencies;

@end


NS_ASSUME_NONNULL_END
