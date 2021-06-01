//
//  TBGroupManager.h
//  SIMDemo
//
//  on 2020/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBGroupManager : NSObject

+ (instancetype)sharedInstanced;

- (void)createGroup:(NSString *)groupName sessionIds:(NSArray<NSString *> *)sessionIds succ:(SIMCreateGroupSucc)succ fail:(SIMFail)fail;

@end

NS_ASSUME_NONNULL_END
