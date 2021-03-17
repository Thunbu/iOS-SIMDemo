//
//  SSocketHeartbeat.h
//  NBIMDemo
//
//  心跳管理器
//
//  Created by changxuanren on 2019/4/24.
//  Copyright © 2019年 常宣任. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSocketHeartbeat : NSObject

+ (instancetype)sharedInstance;

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
