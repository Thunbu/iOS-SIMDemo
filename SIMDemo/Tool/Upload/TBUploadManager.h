//
//  TBUploadManager.h
//  SIMDemo
//
//  on 2021/1/26.
//

#import <Foundation/Foundation.h>
#import <QiniuSDK.h>

typedef void(^UploadComplete) (BOOL,NSDictionary *);
NS_ASSUME_NONNULL_BEGIN

@interface TBUploadManager : NSObject

+ (instancetype)sharedInstance;

- (void)uploadWithFilePath:(NSString *)filePath progress:(QNUpProgressHandler)progress complete:(UploadComplete)complete;

- (void)configQiNiuUploadPolicy:(NSString *)domain token:(NSString *)token;
@end

NS_ASSUME_NONNULL_END
