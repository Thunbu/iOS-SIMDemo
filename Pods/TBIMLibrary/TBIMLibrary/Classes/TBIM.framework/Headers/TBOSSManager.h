//
//  TBOSSManager.h
//  Geely
//
//  Created by changxuanren on 2019/8/2.
//  Copyright © 2019 Geely. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  操作失败回调
 *
 *  @param errorCode 错误码
 *  @param errorDescription 错误描述
 */
typedef void (^TBFail)(NSInteger errorCode, NSString *errorDescription);

/**
 *  文件上传成功回调
 *  @param remoteURL    生成的文件远程URL
 */
typedef void (^TBUploadSucc)(NSString *remoteURL);

/**
 *  文件下载成功回调
 *  @param data 下载的NSData数据
 */
typedef void (^TBDownloadSucc)(NSData *data);

/**
 *  文件上传或下载进度回调
 *
 *  @param curSize      已上传或下载大小
 *  @param totalSize    总大小
 */
typedef void (^TBProgress)(NSInteger curSize, NSInteger totalSize);



@interface TBOSSManager : NSObject

+ (instancetype)sharedInstance;

/// 初始化配置（！！！注意：需要先配置outputURL）
- (void)setupOSSClient;

/// bucketName
@property (nonatomic,copy) NSString *bucketName;

/// 文件输入输出地址
@property (nonatomic,copy) NSString *outputURL;

/// OSS上传授权地址
@property (nonatomic,copy) NSString *policyEncryptURL;

/// OSS相关HTTPS请求头
@property (nonatomic,strong) NSDictionary *policyEncryptHeaderField;

/// 自定义远程文件路径
@property (nonatomic,copy) NSString *objectKeyPath;


#pragma mark - 上传

/**
 *  上传文件（包括图片、视频等）
 
 *  @param filePath 文件路径
 *  @param succ     成功回调
 *  @param fail     失败回调
 */
- (OSSPutObjectRequest *)uploadFilePath:(NSString *)filePath succ:(TBUploadSucc)succ fail:(TBFail)fail;


/**
 *  上传文件（包括图片、视频等），包含进度
 
 *  @param filePath 文件路径
 *  @param progress 进度回调
 *  @param succ     成功回调
 *  @param fail     失败回调
 */
- (OSSPutObjectRequest *)uploadFilePath:(NSString *)filePath progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail;


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


/// 取消某个下载任务，返回是否已经下载布尔值
/// @param url 需要取消的下载任务URL地址
- (BOOL)cancelDownloadRequest:(NSString *)url;


@end

NS_ASSUME_NONNULL_END
