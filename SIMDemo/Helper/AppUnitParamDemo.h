//
//  AppUnitParam.h
//  Geely
//
//  重要全局函数，用于获取系统或自定义重要字段。
//  on 2017/6/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppUnitParamDemo : NSObject

+ (BOOL)isIphoneX;

+ (BOOL)isIphoneXSeries;

/** 检测系统是否处于后台 */
+ (BOOL)systemIsInBack;

/** 检测系统是否处于激活状态 */
+ (BOOL)systemIsInActive;

/**
 * 系统Home角标
 * @param add 加
 * @param sub 减
 * @param equal 等于
 * @param much 振幅
 * 优先级 add > sub > equal
 */
+ (void)systemHomeIconBadgeWithAdd:(BOOL)add sub:(BOOL)sub euqal:(BOOL)equal much:(NSInteger)much;

/** 客户端生成唯一Id */
+ (NSString *)uniqueId;

+ (NSString *)appDisplayName;

+ (NSString *)bundleIdentifierKey;

/**
 获取 IPhone ipad 型号
 @return IPhone ipad 型号
 */
+ (NSString *)getIphoneType;
@end
