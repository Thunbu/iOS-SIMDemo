//
//  NSString+Encrypt.h
//  AESDemo
//
//  Created by ZhangLiang on 15/10/26.
//  Copyright © 2015年 kfzx-zhangys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

+ (NSString *)encodeBase64String:(NSString *)input;

+ (NSData *)decodeBase64String:(NSString *)input;

+ (NSString *)encodeBase64Data:(NSData *)data;

+ (NSString *)decodeBase64Data:(NSData *)data;

@end
