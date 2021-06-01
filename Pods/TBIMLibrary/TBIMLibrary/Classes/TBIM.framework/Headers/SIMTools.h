//
//  SIMTools.h
//  NBIMDemo
//
//  on 2019/5/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIMTools : NSObject

/**
 生成32位UUID
 */
+ (NSString *)uuidString;

//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


@end

NS_ASSUME_NONNULL_END
