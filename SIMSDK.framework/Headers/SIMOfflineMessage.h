//
//  SIMOfflineMessage.h
//  AFNetworking
//
//  Created by changxuanren on 2019/10/8.
//

#import "SIMBaseMessage.h"
#import "SIMComm+Control.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMOfflineMessage : SIMBaseMessage

/**
 *  TYPE为下线类型，0【原4】为主动下线，1【原5】为被挤下线，2【原6】为自己踢自己下线，3为修改密码被下线，4为账号被禁用下线通知
 */
@property (nonatomic,assign) SIMOfflineType type;

@end

NS_ASSUME_NONNULL_END
