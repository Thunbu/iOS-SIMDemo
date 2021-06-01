//
//  SIMLogManager.h
//  SIMSDK
//
//  on 2021/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIMLogManager : NSObject

+ (void)SIM_saveLog:(NSString *)log;
@end

NS_ASSUME_NONNULL_END
