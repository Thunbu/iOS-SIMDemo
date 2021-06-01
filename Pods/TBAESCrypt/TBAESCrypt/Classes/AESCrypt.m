//
//  AESCrypt.m
//  Gurpartap Singh
//
//  Created by Gurpartap Singh on 06/05/12.
//  Copyright (c) 2012 Gurpartap Singh
//
// 	MIT License
//
// 	Permission is hereby granted, free of charge, to any person obtaining
// 	a copy of this software and associated documentation files (the
// 	"Software"), to deal in the Software without restriction, including
// 	without limitation the rights to use, copy, modify, merge, publish,
// 	distribute, sublicense, and/or sell copies of the Software, and to
// 	permit persons to whom the Software is furnished to do so, subject to
// 	the following conditions:
//
// 	The above copyright notice and this permission notice shall be
// 	included in all copies or substantial portions of the Software.
//
// 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// 	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// 	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// 	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// 	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// 	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// 	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "AESCrypt.h"
#import "NSData+CommonCrypto.h"
#import "NSString+Encrypt.h"

@implementation AESCrypt
// 加密
+ (NSString *)encrypt:(NSString *)message password:(NSString *)password {
    NSData *encryptedData = [[message dataUsingEncoding:NSUTF8StringEncoding]
                             AES256EncryptedDataUsingKey:[password dataUsingEncoding:NSUTF8StringEncoding]
                             error:nil];
    NSString *base64EncodedString = [NSString encodeBase64Data:encryptedData];
    
    return base64EncodedString;
}
+ (NSString *)encryptDefault:(NSString *)message {
    return [AESCrypt encrypt:message password:@"CD6F7D08DF62341A"];
}

// 解密
+ (NSString *)decrypt:(NSString *)base64EncodedString password:(NSString *)password {
    NSData *encryptedData = [NSString decodeBase64String:base64EncodedString];
    NSData *decryptedData = [encryptedData
                             decryptedAES256DataUsingKey:[password dataUsingEncoding:NSUTF8StringEncoding]
                             error:nil];
    NSString *res =
    [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    return res;
}
+ (NSString *)decryptDefault:(NSString *)base64EncodedString {
    return [AESCrypt decrypt:base64EncodedString password:@"CD6F7D08DF62341A"];
}

@end
