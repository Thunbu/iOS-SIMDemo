//
//  SIMDataResolved.h
//  NBIMDemo
//
//  将需要的数据转成Model类型
//
//  Created by 一个工匠 on 2019/6/2.
//  Copyright © 2019 闪布科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SIMError;

NS_ASSUME_NONNULL_BEGIN

@interface SIMDataResolved : NSObject

/**
 *  根据传输的字符串数据进行解析
 *
 *  @param string 传输字传输数据
 *  @param completion command:命令id packetId：包id    response：解析类型   error：错误类型
 */
+ (void)resolvedString:(id)string completion:(void(^)(NSInteger command, NSString * _Nullable packetId, _Nullable id response, SIMError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
