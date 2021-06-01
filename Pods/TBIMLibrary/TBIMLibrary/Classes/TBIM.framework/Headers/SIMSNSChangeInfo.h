//
//  SIMSNSMessage.h
//  NBIMDemo
//
//  on 2019/6/4.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIMComm+Friend.h"

NS_ASSUME_NONNULL_BEGIN


/////////////////////////////////////////////////////////////////////////////////
//
//                      (一）关系链变更详细信息
//
/////////////////////////////////////////////////////////////////////////////////

/**
 *  关系链变更详细信息
 */
@interface SIMSNSChangeInfo : NSObject
/**
 * 操作类型
 */
@property(nonatomic,assign) SIM_SNS_SYSTEM_TYPE type;

/**
 *  用户 identifierx
 */
@property(nonatomic,strong) NSString * identifier;

/**
 记录ID
 */
@property(nonatomic,strong) NSString * reqId;

/**
 头像
 */
@property(nonatomic,strong) NSString * faceURL;

/**
 *  用户昵称
 */
@property(nonatomic,strong) NSString * nickname;

/**
 *  申请添加时有效，添加理由
 */
@property(nonatomic,strong) NSString * wording;

/**
 *  申请时填写，添加来源
 */
@property(nonatomic,strong) NSString * source;

/**
 *  备注 type=TIM_SNS_SYSTEM_SNS_PROFILE_CHANGE 有效
 */
@property(nonatomic,strong) NSString * remark;

/**
 同意/拒绝 type = SIM_SNS_SYSTEM_ADD_FRIEND 时有效
 */
@property(nonatomic,assign) BOOL agree;

@end



NS_ASSUME_NONNULL_END
