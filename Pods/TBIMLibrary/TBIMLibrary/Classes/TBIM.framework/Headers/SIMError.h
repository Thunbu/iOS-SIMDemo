//
//  SIMError.h
//  NBIMDemo
//
//  on 2019/5/8.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 错误类
 */
@interface SIMError : NSObject

/**
 @property
 @brief 错误类型
 */
@property (nonatomic, readonly)NSInteger errorCode;

/**
 @property
 @brief 错误类型描述
 */
@property (nonatomic, copy) NSString *errorDescription;

/**
 @param errorCode 错误类型
 @return 错误
 */

+ (nullable SIMError *)errorWithCode:(NSInteger)errorCode;

@end

NS_ASSUME_NONNULL_END
