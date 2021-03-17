//
//  NSDate+Show.m
//  Geely
//
//  Created by wangjie on 2017/12/21.
//  Copyright © 2017年 Geely. All rights reserved.
//

#import "NSDate+Show.h"

@implementation NSDate (Show)

+ (NSString *)timeStringWithTimeInterval:(NSString *)timeInterval {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //  [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"]];
    NSDate *date = [NSDate
        dateWithTimeIntervalSince1970:timeInterval.longLongValue / 1000]; //此处根据项目需求,选择是否除以1000 , 如果时间戳精确到秒则去掉1000

    //今天
    if ([date isToday]) {
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"%@ %@", [self getDayStatus:date], [formatter stringFromDate:date]];
    } else {
        if ([date isYesterday]) {
            //昨天
            formatter.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天 %@", [formatter stringFromDate:date]];

        } else if ([date deltaWithNow]) {
            //一周内 [date weekdayStringFromDate]
            formatter.dateFormat = [NSString stringWithFormat:@"%@ %@", [date weekdayStringFromDate], @"HH:mm"];
            return [formatter stringFromDate:date];
        } else {
            //直接显示年月日
            formatter.dateFormat = @"yyyy-MM-dd";
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}
#pragma mark =================== 在聊天详情页的时间显示 ===================
+ (NSString *)timeStringWithTimeInterval_IMChat:(NSString *)timeInterval {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //  [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"Asia/Shanghai"]];
    NSDate *date = [NSDate
                    dateWithTimeIntervalSince1970:timeInterval.longLongValue / 1000]; //此处根据项目需求,选择是否除以1000 , 如果时间戳精确到秒则去掉1000
    
    //今天
    if ([date isToday]) {
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    } else {
        if ([date isYesterday]) {
            //昨天
            formatter.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天 %@", [formatter stringFromDate:date]];
            
        } else if ([date deltaWithNow]) {
            //一周内 [date weekdayStringFromDate]
            formatter.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"%@ %@", [date weekdayStringFromDate], [formatter stringFromDate:date]];
        } else {
            //（往前7天）年月日+24小时制
            formatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}

+ (NSString *)timeStringWithTimeInterval_IMChat_todo:(NSString *)timeInterval {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval.longLongValue / 1000];
    //今天
    if ([date isToday]) {
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    } else {
        formatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
        return [formatter stringFromDate:date];
    }
    return nil;
}
#pragma mark - 云盘最近使用时间 展示
+ (NSString *)timeMinuteStringWithInterval:(NSString *)timeInterval{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval.longLongValue / 1000];
    //今天
    if ([date isToday]) {
        NSUInteger seconds = timeInterval.longLongValue / 1000;
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] - seconds;
        if (interval < 3600){
            NSUInteger minutes = interval/60;
            if (minutes < 1){
                minutes = 1;
            }
            NSString *secondStr = [NSString stringWithFormat:@"%lu分钟前", (unsigned long)minutes];
            return secondStr;
        }
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    } else {
        if ([date isYesterday]) {
            //昨天
            formatter.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天 %@", [formatter stringFromDate:date]];

        } else if ([date deltaWithNow]) {
            //一周内 [date weekdayStringFromDate]
            formatter.dateFormat = [NSString stringWithFormat:@"%@ %@", [date weekdayStringFromDate], @"HH:mm"];
            return [formatter stringFromDate:date];
        } else {
            //直接显示年月日
            formatter.dateFormat = @"yyyy-MM-dd";
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}
#pragma mark =================== 在会话列表页面的时间显示 ===================
+ (NSString *)timeStringWithTimeInterval_Session:(NSString *)timeInterval {
    if (timeInterval.length != 13) {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval.longLongValue / 1000]; //此处根据项目需求,选择是否除以1000 , 如果时间戳精确到秒则去掉1000
    
    //今天
    if ([date isToday]) {
        formatter.dateFormat = @"HH:mm";
        return [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    } else {
        if ([date isYesterday]) {
            //昨天
            return @"昨天";
        } else if ([date deltaWithNow]) {
            //一周内
            return [date weekdayStringFromDate];
        } else {
            //（往前7天）年月日
            formatter.dateFormat = @"yyyy/MM/dd";
            return [formatter stringFromDate:date];
        }
    }
    return nil;
}

//是否在同一周
- (BOOL)isSameWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitWeekOfMonth | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekdayOrdinal;
    // 1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.weekOfMonth == nowCmps.weekOfMonth);
}

//是否在同一年
- (BOOL)isSameYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitWeekOfMonth | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekdayOrdinal;
    // 1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (selfCmps.year == nowCmps.year);
}

//根据日期求星期几
- (NSString *)weekdayStringFromDate {
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];

    [calendar setTimeZone:timeZone];

    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;

    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];

    return [weekdays objectAtIndex:theComponents.weekday];
}

//是否为今天
- (BOOL)isToday {
    // self 调用这个方法的对象本身
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    // 1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

//是否为昨天
- (BOOL)isYesterday {
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    NSDate *selfDate = [self dateWithYMD];
    //获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

//格式化
- (NSDate *)dateWithYMD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

+ (NSString *)getDayStatus:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H"];
    NSString *day = [dateFormatter stringFromDate:date];

    if (day.intValue >= 5 && day.intValue < 12) {
        return @"早上";
    } else if (day.intValue >= 12 && day.intValue < 19) {
        return @"下午";
    } else {
        return @"晚上";
    }
}

/**
 *  获得与当前时间的差距
 */
- (BOOL)deltaWithNow {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
    NSInteger hour = 7 * 24;
    if (cmps.hour > hour) {
        return NO;
    } else {
        return YES;
    }
}

/** 处理13位时间戳 */
+ (NSString *)getTimeFromTimestamp:(NSString *)timeInterval {
    //时间戳为空时返回空字符串
    if (!timeInterval) {
        return @"";
    }
    //时间戳长度容错
    if (timeInterval.length != 13) {
        if (timeInterval.length == 10) {
            timeInterval = [timeInterval stringByAppendingString:@"000"];
        }else {
            return @"";
        }
    }
    NSTimeInterval interval = [timeInterval doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate: date];
    return dateString;
}

@end
