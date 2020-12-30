//
//  SIMError.h
//  NBIMDemo
//
//  Created by 王杰 on 2019/5/8.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  错误类
 */
@interface SIMError : NSObject

/**
 *  错误类型
 */
@property (nonatomic, readonly) NSInteger errorCode;

/**
 *  错误类型描述
 */
@property (nonatomic, copy) NSString *errorDescription;

/**
 *  初始化实例
 *  @param errorCode 错误类型
 *  @return SIMError实例
 */

+ (nullable SIMError *)errorWithCode:(NSInteger)errorCode;

@end

NS_ASSUME_NONNULL_END
