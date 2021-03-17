//
//  SIMMultiterminalLoginStateMessage.h
//  AFNetworking
//
//  Created by 王杰 on 2019/7/4.
//

#import <Foundation/Foundation.h>
#import "SIMComm+Session.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMMultiterminalLoginStateMessage : NSObject

@property (nonatomic, strong) NSString * time;

/**
 *  终端类型
 */
@property (nonatomic, assign) NSInteger terminal;

/**
 *  多端登录状态
 */
@property (nonatomic, assign) SIMMultiterminalLoginState loginState;

/**
 *  状态是否 在线  YES 在线
 */
@property (nonatomic, assign) BOOL isON;

@end


@interface SIMMultiterminalLogin : NSObject

/**
 *  多端登录状态数组
 */
@property (nonatomic, strong) NSArray <SIMMultiterminalLoginStateMessage*> * data;

@end




NS_ASSUME_NONNULL_END
