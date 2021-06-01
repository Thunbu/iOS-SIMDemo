//
//  TBOSSBaseManager.h
//  TBOSSManager
//
//  Created by changxuanren on 2021/3/11.
//

#import <Foundation/Foundation.h>
#import "TBOSSConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface TBOSSBaseManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,strong) TBOSSConfig *config;

- (void)initWithConfig:(TBOSSConfig *)config;

//上传
- (id)uploadData:(NSData *)data objectKey:(NSString *)objectKey progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail;

//下载
- (void)downloadData:(NSString *)url progress:(TBProgress)progress succ:(TBDownloadSucc)succ fail:(TBFail)fail;


#pragma mark - 取消任务

/// 取消上传或下载任务
/// @param request 上传或下载对象
- (void)cancelRequest:(id)request;

/// 判断上传或下载任务十分是取消状态
/// @param request 上传或下载对象
- (BOOL)isCancelledOfRequest:(id)request;

/// 取消某个下载任务，返回是否已经下载布尔值
/// @param url 需要取消的下载任务URL地址
- (BOOL)cancelDownloadRequest:(NSString *)url;


#pragma mark - 其他

/// 获取缩略图完整URL字符串
/// @param host host
/// @param ratio 缩略图最长边
- (NSString *)thumbImageURLStringWithHost:(NSString *)host ratio:(NSInteger)ratio;


@end

NS_ASSUME_NONNULL_END
