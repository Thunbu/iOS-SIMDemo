//
//  SIMRecentMessage.h
//  AFNetworking
//
//  on 2019/7/5.
//

#import <Foundation/Foundation.h>
#import "SIMBaseMessage.h"
#import "SIMComm+Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMRecentMessage : SIMBaseMessage

@property (nonatomic,assign) long lastMsgTime;
@property (nonatomic,assign) long loginTime;
@property (nonatomic,copy) NSString *tId; //最后一条消息的后台ID
@property (nonatomic,assign) SIMRecentQueryType queryType;

@end


@interface SIMRecentMsgPage : NSObject

@property (nonatomic,strong) NSArray *messageList;
@property (nonatomic,assign) BOOL lastPage;
@property (nonatomic,assign) SIMRecentQueryType queryType;
@property (nonatomic,assign) long lastMsgTime;
@property (nonatomic,copy) NSString *tId; //最后一条消息的后台ID
@property (nonatomic,strong) NSArray *data;

@end

NS_ASSUME_NONNULL_END
