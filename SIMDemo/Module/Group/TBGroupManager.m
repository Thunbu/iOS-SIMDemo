//
//  TBGroupManager.m
//  SIMDemo
//
//  Created by changxuanren on 2020/10/30.
//

#import "TBGroupManager.h"

@implementation TBGroupManager

- (void)createGroup:(NSString *)groupName sessionIds:(NSArray<NSString *> *)sessionIds succ:(SIMCreateGroupSucc)succ fail:(SIMFail)fail {
    if (!sessionIds || sessionIds.count == 0) {
        return;
    }  
    [[SIMGroupManager sharedInstance] createGroup:groupName type:SIMGroupType_Internal userIds:sessionIds succ:^(NSString * _Nonnull groupId) {
        succ ? succ(groupId) : nil;
    } fail:^(SIMError * _Nonnull error) {
        fail ? fail(error) : nil;
    }];
}

+ (instancetype)sharedInstanced {
    static TBGroupManager *instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[TBGroupManager alloc] init];
    });
    return instance;
}

@end
