//
//  TBOSSManager.h
//  Geely
//
//  Created by changxuanren on 2019/8/2.
//  Copyright © 2019 Geely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBOSSConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface TBOSSManager : NSObject

#pragma mark - 初始化

+ (instancetype)sharedInstance;

/// 初始化配置
/// @param config 配置参数
- (void)initWithConfig:(TBOSSConfig *)config;


#pragma mark - 上传

/**
 *  上传文件（包括图片、视频等）
 
 *  @param filePath 文件路径
 *  @param succ     成功回调
 *  @param fail     失败回调
 */
- (id)uploadFilePath:(NSString *)filePath succ:(TBUploadSucc)succ fail:(TBFail)fail;


/**
 *  上传文件（包括图片、视频等），包含进度
 
 *  @param filePath 文件路径
 *  @param progress 进度回调
 *  @param succ     成功回调
 *  @param fail     失败回调
 */
- (id)uploadFilePath:(NSString *)filePath progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail;


/// 上传文件（由业务方设置远程路径中的文件名称）
/// @param filePath 文件路径
/// @param fileName 文件名称
/// @param succ 成功回调
/// @param fail 失败回调
- (void)uploadFilePath:(NSString *)filePath fileName:(NSString *)fileName succ:(TBUploadSucc)succ fail:(TBFail)fail;


/**
 上传图片
 
 @param image 图片对象
 @param succ 成功回调
 @param fail 失败回调
 */
- (void)uploadImage:(UIImage *)image succ:(TBUploadSucc)succ fail:(TBFail)fail;


/**
 上传图片，包含进度
 
 @param image 图片对象
 @param progress 进度回调
 @param succ 成功回调
 @param fail 失败回调
 */
- (void)uploadImage:(UIImage *)image progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail;

/**
上传文件

@param fileData 二进制Data
@param suffix 后缀名（如jpg、gif、mp4）
@param succ 成功回调
@param fail 失败回调
*/
- (void)uploadFileData:(NSData *)fileData suffix:(NSString *)suffix succ:(TBUploadSucc)succ fail:(TBFail)fail;

/**
上传文件，包含进度

@param fileData 二进制Data
@param suffix 后缀名（如jpg、gif、mp4）
@param progress 进度回调
@param succ 成功回调
@param fail 失败回调
*/
- (void)uploadFileData:(NSData *)fileData suffix:(NSString *)suffix progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail;


#pragma mark - 下载

/**
 *  下载文件（包括图片、视频等）
 
 *  @param remoteURL    文件远程URL
 *  @param succ         成功回调
 *  @param fail         失败回调
 */
- (void)downloadRemoteURL:(NSString *)remoteURL succ:(TBDownloadSucc)succ fail:(TBFail)fail;


/**
 *  下载文件（包括图片、视频等），包含进度
 
 *  @param remoteURL    文件远程URL
 *  @param progress     进度回调
 *  @param succ         成功回调
 *  @param fail         失败回调
 */
- (void)downloadRemoteURL:(NSString *)remoteURL progress:(TBProgress)progress succ:(TBDownloadSucc)succ fail:(TBFail)fail;


/**
 *  下载文件（包括图片、视频等），包含存储路径
 
 *  @param remoteURL    文件远程URL
 *  @param savaPath     文件保存路径
 *  @param succ         成功回调
 *  @param fail         失败回调
 */
- (void)downloadRemoteURL:(NSString *)remoteURL savaPath:(NSString *)savaPath succ:(TBDownloadSucc)succ fail:(TBFail)fail;


/**
 *  下载文件（包括图片、视频等），包含存储路径和进度
 
 *  @param remoteURL    文件远程URL
 *  @param savaPath     文件保存路径
 *  @param progress     进度回调
 *  @param succ         成功回调
 *  @param fail         失败回调
 */
- (void)downloadRemoteURL:(NSString *)remoteURL savaPath:(NSString *)savaPath progress:(TBProgress)progress succ:(TBDownloadSucc)succ fail:(TBFail)fail;



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

/// 获取缩略图（大图也是通过此方法设置）完整URL字符串
/// @param host host
/// @param ratio 缩略图最长边
- (NSString *)thumbImageURLStringWithHost:(NSString *)host ratio:(NSInteger)ratio;


@end

NS_ASSUME_NONNULL_END
