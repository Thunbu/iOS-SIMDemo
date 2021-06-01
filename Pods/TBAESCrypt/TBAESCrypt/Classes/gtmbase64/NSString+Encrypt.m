//
//  NSString+Encrypt.m
//  AESDemo
//
//  Created by ZhangLiang on 15/10/26.
//  Copyright © 2015年 kfzx-zhangys. All rights reserved.
//

#import "GTMBase64.h"
#import "NSString+Encrypt.h"

// static const char encodingTable[] =
// "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

@implementation NSString (Encrypt)

+ (NSString *)encodeBase64String:(NSString *)input {
  NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
  data = [GTMBase64 encodeData:data];
  NSString *base64String =
      [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  return base64String;
}

+ (NSData *)decodeBase64String:(NSString *)input {
  NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
  data = [GTMBase64 decodeData:data];
  return data;
}

+ (NSString *)encodeBase64Data:(NSData *)data {
  data = [GTMBase64 encodeData:data];
  NSString *base64String =
      [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  return base64String;
}

+ (NSString *)decodeBase64Data:(NSData *)data {
  data = [GTMBase64 decodeData:data];
  NSString *base64String =
      [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  return base64String;
}

@end
