//
//  SIMDeviceManager.h
//  AFNetworking
//
//  Created by changxuanren on 2019/7/3.
//

#import <Foundation/Foundation.h>
#import "SIMComm.h"
#import "SIMBaseMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMDeviceMessage : SIMBaseMessage

/**
 *  设备ID，可能是deviceToken，也可能是clientId
 */
@property (nonatomic, copy) NSString *deviceId;

/**
 *  设备类型，iOS传"ios"
 */
@property (nonatomic, copy) NSString *deviceType;

@end



@interface SIMDeviceManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  上传终端设备信息，用于消息推送
 *
 *  @param deviceId 设备token
 *  @param succ     成功回调
 *  @param fail     失败回调
 *  @return 0：成功；1：失败
 */
- (int)report:(NSString *)deviceId succ:(SIMSucc)succ fail:(SIMFail)fail;


@end

NS_ASSUME_NONNULL_END
