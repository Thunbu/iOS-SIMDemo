//
//  AppMacro.m
//  SIMDemo
//
//  Created by xiaobing on 2020/11/2.
//

#import <Foundation/Foundation.h>

//HEIGHT
#define UIScreenBounds ([UIScreen mainScreen].bounds)
#define UIScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define UIScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define StatusHeight ([AppUnitParam isIphoneXSeries] ? 44 : 20)
#define StatusNavBarHeight ([AppUnitParam isIphoneXSeries] ? 88 : 64)
#define BottomSafeHeight ([AppUnitParam isIphoneXSeries] ? 34 : 0)

//FONT
#define Regular(fontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize]
#define Medium(fontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize]
#define Bold(fontSize) [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize]
