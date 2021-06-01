//
//  TBFileManager.h
//  SIMDemo
//
//  on 2021/1/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBFileManager : NSObject

+ (instancetype)sharedInstance;

- (NSString *)copyToLocalWithData:(NSData *)data toPath:(NSString *)path;
- (NSString *)getCopyFilePath:(NSString *)fileName;
- (NSString *)getDateStr;
- (void)deleteFileWithPath:(NSString *)filePath;

- (CGFloat)sizeWithPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
