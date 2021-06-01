//
//  TBOSSConfig.h
//  TBOSSManager
//
//  Created by changxuanren on 2021/3/11.
//

#import <Foundation/Foundation.h>

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


/// SDK类型
typedef NS_ENUM(NSInteger, TBOSSSDKType) {
    TBOSSSDKType_AliCloud = 0, //阿里云
    TBOSSSDKType_HuaweiCloud = 1, //华为云
};


@interface TBOSSConfig : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic,assign) TBOSSSDKType sdkType;

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

@end

NS_ASSUME_NONNULL_END
