//
//  NSDate+Show.h
//  Geely
//
//  Created by wangjie on 2017/12/21.
//  Copyright © 2017年 Geely. All rights reserved.
//

@interface NSDate (Show)

/**
 时间戳 转为  字符串样式

 @param timeInterval 时间戳
 @return 字符串
 */
+ (NSString *)timeStringWithTimeInterval:(NSString *)timeInterval;

/**
 在聊天详情页中 时间戳 转为  字符串样式

 @param timeInterval 时间戳
 @return 字符串
 */
+ (NSString *)timeStringWithTimeInterval_IMChat:(NSString *)timeInterval;

/**
 聊天消息中的待办消息时间展示
 */
+ (NSString *)timeStringWithTimeInterval_IMChat_todo:(NSString *)timeInterval;

/**
 在会话列表页面 时间戳 转为  字符串样式
 
 @param timeInterval 时间戳
 @return 字符串
 */
+ (NSString *)timeStringWithTimeInterval_Session:(NSString *)timeInterval;


/// 云盘 我的空间列表
/// @param timeInterval 时间戳
+ (NSString *)timeMinuteStringWithInterval:(NSString *)timeInterval;
/**
 将服务器返回的时间戳转换为标准时间 xxxx-xx-xx xx:xx  形如2018-06-07 10:12:31

 @param timeInterval 时间戳
 @return 标准时间字符串
 */
+ (NSString *)getTimeFromTimestamp:(NSString *)timeInterval;
@end
