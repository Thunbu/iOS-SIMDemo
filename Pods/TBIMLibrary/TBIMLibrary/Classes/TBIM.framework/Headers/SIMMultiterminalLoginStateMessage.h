//
//  SIMMultiterminalLoginStateMessage.h
//  AFNetworking
//
//  on 2019/7/4.
//

#import <Foundation/Foundation.h>
#import "SIMComm+Session.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMMultiterminalLoginStateMessage : NSObject

@property (nonatomic, strong) NSString * time;

@property (nonatomic, assign) NSInteger terminal;

@property (nonatomic, assign) SIMMultiterminalLoginState loginState;

@property (nonatomic, assign) BOOL isON; //状态是否 在线  YES 在线

@end


@interface SIMMultiterminalLogin : NSObject

@property (nonatomic, strong) NSArray <SIMMultiterminalLoginStateMessage*> * data;

@end




NS_ASSUME_NONNULL_END
