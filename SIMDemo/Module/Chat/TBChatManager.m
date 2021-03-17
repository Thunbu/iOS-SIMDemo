//
//  TBChatManager.m
//  SIMDemo
//
//  Created by changxuanren on 2020/11/2.
//

#import "TBChatManager.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "TBSessionManager.h"
#import "NSArray+SIMMessage.h"

@interface TBIMChatMessageDelegateNode : NSObject
@property (nonatomic,weak,readonly)id delegate;
@end

@implementation TBIMChatMessageDelegateNode
-(id)initWithDelegate:(id)delegate {
    self = [super init];
    _delegate = delegate;
    return self;
}
@end


@interface TBChatManager ()
@property(nonatomic, copy)NSString *currentUser;
@property (nonatomic, strong) NSMutableArray<TBIMChatMessageDelegate> *delegates;
@end


@implementation TBChatManager

- (void)remberCurrentUser:(NSString *)userId{
    if (!userId){
        return;
    }
    self.currentUser = userId;
}
- (NSString *)currentUserId{
    return _currentUser;
}
// 注册消息接收监听
- (void)registerDelegate:(id)delegate {
    TBIMChatMessageDelegateNode *node = [[TBIMChatMessageDelegateNode alloc] initWithDelegate:delegate];
    if (![self.delegates containsObject:node]) {
        [self.delegates addObject:node];
    }
}
// 删除监听
- (void)unRegisterDelegate:(id)delegate {
    for (TBIMChatMessageDelegateNode *node in self.delegates) {
        if (nil == node.delegate || node.delegate == delegate) {
            [self.delegates removeObject:node];
            break;
        }
    }
}
// 消息接收总入口
- (void)receiveMessage:(SIMMessage *)msg {
    [self resoveMsgsToListener:@selector(messageDidReceived:) param:msg];
}
// 删除消息入口
- (void)deleteMessage:(SIMMessage *)msg completion:(void(^)(SIMMessage *msg, SIMError *error))completion {
    //构建删除消息体
    SIMDeleteElem *elem = [[SIMDeleteElem alloc] init];
    elem.messageId = msg.packetId; //消息ID
    SIMMessage *message = [[SIMMessage alloc] initWithReceiver:[msg getSessionId] chatType:[[TBSessionManager sharedInstanced] getSIMSessionTypeOfSessionId:[msg getSessionId]]];
    [message setElem:elem];
    //发送删除消息
    [[SIMMessageManager sharedInstance] deleteMessage:message succ:^(id  _Nonnull data) {
        if (data){
            completion(msg, nil);
        }
    } fail:^(SIMError * _Nonnull error) {
        completion(nil, error);
    }];
}
// 回调给registerDelegate 里注册的对象
- (void)resoveMsgsToListener:(SEL)select param:(id)param {
    // 切换到主线程通知到业务方
    dispatch_async(dispatch_get_main_queue(), ^{
        for (TBIMChatMessageDelegateNode *node in self.delegates) {
            id<TBIMChatMessageDelegate> listener = node.delegate;
            if (listener && [listener respondsToSelector:select]) {
                ((void (*)(id, SEL, id))objc_msgSend)(listener, select, param);
            }
        }
    });
}

- (void)pullHistoryMsgsOfSession:(NSString *)sessionId fromMsgId:(nullable NSString *)msgId completion:(void(^)(NSArray<SIMMessage *> *msgs, SIMError *error))completion {
    SIMOfflineAllMsgReq *req = [SIMOfflineAllMsgReq new];
    req.sessionId = sessionId;
    req.sessionType = [[TBSessionManager sharedInstanced] getSIMSessionTypeOfSessionId:sessionId];
    req.securityType = SIMSecType_NORMAL;
    if (msgId) {
        req.msgId = msgId;
    }
    req.rows = 50;
    req.type = SIMMessagePullType_New;
    
    [[SIMMessageManager sharedInstance] pullAllMsgList:req succ:^(NSArray<SIMMessage *> * _Nonnull msgs, NSArray<SIMMessage *> * _Nonnull cmdMsgs) {
        completion ? completion(msgs, nil) : nil;
    } fail:^(SIMError * _Nonnull error) {
        completion ? completion(nil, error) : nil;
    }];
}

- (void)sendTextMessageTo:(NSString *)to text:(NSString *)text atArray:(NSArray *)atArray completion:(void(^)(SIMMessage *, SIMError *error))completion{
    SIMTextElem *elem = [SIMTextElem new];
    [elem setText:text];
    if (atArray && atArray.count > 0) {
        //@群人员消息
        elem.members = atArray;
        elem.isAt = YES;
    }
    SIMMessage *msg = [[SIMMessage alloc] initWithReceiver:to chatType:[[TBSessionManager sharedInstanced] getSIMSessionTypeOfSessionId:to]];
    [msg setElem:elem];

    [[SIMMessageManager sharedInstance] sendMessage:msg succ:^(id  _Nonnull data) {
        if (data){
            completion((SIMMessage *)data, nil);
        }
    } fail:^(SIMError * _Nonnull error) {
        completion(nil, error);
    }];
}

//注意：发送图片和视频消息，宽高和大小等参数需要业务方传递真实值，以保证消息的可靠性
- (void)sendImageMessageTo:(NSString *)to url:(NSString *)url isHD:(BOOL)isHD completion:(void(^)(SIMMessage *, SIMError *error))completion{
    SIMImageElem *elem = [SIMImageElem new];
    elem.format = SIM_IMAGE_FORMAT_JPG;
    elem.isHD = isHD;
    
    //原图
    SIMImage * orgImg = [SIMImage new];
    orgImg.url = url;
    orgImg.width = 600;
    orgImg.height = 600;
    orgImg.size = 1024;
    orgImg.type = SIMImageType_Original;
    //大图
    SIMImage * largeImg = [SIMImage new];
    largeImg.width = 400;
    largeImg.height = 400;
    largeImg.url = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,l_720",url];
    largeImg.type = SIMImageType_Large;
    largeImg.size = 512;
    //缩略图
    SIMImage * thumbImg = [SIMImage new];
    thumbImg.url = [NSString stringWithFormat:@"%@?x-oss-process=image/resize,l_198",url];
    thumbImg.width = 300;
    thumbImg.height = 300;
    thumbImg.type = SIMImageType_Thumb;
    thumbImg.size = 256;
    //区分发送时候原图和非原图
    if (isHD) {
        elem.imageList = @[orgImg,thumbImg,largeImg];
    } else {
        elem.imageList = @[thumbImg,largeImg];
    }
    
    SIMMessage *msg = [[SIMMessage alloc] initWithReceiver:to chatType:[[TBSessionManager sharedInstanced] getSIMSessionTypeOfSessionId:to]];
    [msg setElem:elem];

    [[SIMMessageManager sharedInstance] sendMessage:msg succ:^(id  _Nonnull data) {
        if (data){
            completion((SIMMessage *)data, nil);
        }
    } fail:^(SIMError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)sendVideoMessageTo:(NSString *)to url:(NSString *)url coverUrl:(NSString *)coverUrl completion:(void(^)(SIMMessage *, SIMError *error))completion{
    SIMVideoElem *elem = [SIMVideoElem new];
    elem.videoUrl = url;
    elem.videoSize = 2492145;
    elem.duration = 5*1000;
    elem.videoFormat = [self videoFormatForPath:url];
    
    elem.coverUrl = coverUrl;
    elem.coverSize = 135455;
    elem.coverHeight = 200;
    elem.coverWidth = 300;
    elem.coverFormat = SIM_IMAGE_FORMAT_JPG;
    
    SIMMessage *msg = [[SIMMessage alloc] initWithReceiver:to chatType:[[TBSessionManager sharedInstanced] getSIMSessionTypeOfSessionId:to]];
    [msg setElem:elem];

    [[SIMMessageManager sharedInstance] sendMessage:msg succ:^(id  _Nonnull data) {
        if (data){
            completion((SIMMessage *)data, nil);
        }
    } fail:^(SIMError * _Nonnull error) {
        completion(nil, error);
    }];
}
- (SIMVideoFormat)videoFormatForPath:(NSString *)path {
    if ([path.pathExtension localizedCaseInsensitiveContainsString:@"avi"]) {
        return SIMVideoFormat_AVI;
    }
    else if ([path.pathExtension localizedCaseInsensitiveContainsString:@"rm"]) {
        return SIMVideoFormat_RM;
    }
    else if ([path.pathExtension localizedCaseInsensitiveContainsString:@"rmvb"]) {
        return SIMVideoFormat_RMVB;
    }
    else if ([path.pathExtension localizedCaseInsensitiveContainsString:@"wmv"]) {
        return SIMVideoFormat_WMV;
    }
    else if ([path.pathExtension localizedCaseInsensitiveContainsString:@"mp4"]) {
        return SIMVideoFormat_MP4;
    }
    else if ([path.pathExtension localizedCaseInsensitiveContainsString:@"mov"]) {
        return SIMVideoFormat_MOV;
    }
    return SIMVideoFormat_UNKNOWN;
}

- (NSMutableArray<TBIMChatMessageDelegate> *)delegates {
    if (!_delegates) {
        _delegates = [NSMutableArray<TBIMChatMessageDelegate> new];
    }
    return _delegates;
}

+ (instancetype)sharedInstanced {
    static TBChatManager *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[TBChatManager alloc] init];
    });
    return instance;
}


@end
