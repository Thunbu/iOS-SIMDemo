//
//  SIMCallManager.h
//  AFNetworking
//
//  Created by changxuanren on 2019/7/29.
//

#import <Foundation/Foundation.h>
#import "SIMComm.h"
#import "SIMCallMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMCallManager : NSObject

+ (instancetype)sharedInstance;


/**
 *  发送音视频通话相关消息
 *
 *  @param simCall  发送消息体
 *  @param succ     成功回调
 *  @param fail     失败回调
 *  @return 0：成功；1：失败
 */
- (int)call:(SIMCallMessage *)simCall succ:(SIMSuccData)succ fail:(SIMFail)fail;


/**
 *  获取群通话成员
 *
 *  @param groupId  群组ID
 *  @param succ     成功回调
 *  @param fail     失败回调
 *  @return 0：成功；1：失败
 */
- (int)getVideoGroupUsers:(NSString *)groupId succ:(SIMSuccData)succ fail:(SIMFail)fail;


@end

NS_ASSUME_NONNULL_END
