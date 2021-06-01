//
//  TBOSSManager.m
//  Geely
//
//  Created by changxuanren on 2019/8/2.
//  Copyright © 2019 Geely. All rights reserved.
//

#import "TBOSSManager.h"
#import "TBAliOSSManager.h"
#import "TBHuaweiOSSManager.h"
#import <AFNetworking/AFNetworking.h>

@interface TBOSSManager ()
@property (nonatomic,strong) TBOSSConfig *config;
/// 下载管理器
@property (nonatomic,strong) AFURLSessionManager *sessionManager;
/// 下载请求数组
@property (nonatomic,strong) NSMutableArray<NSURLSessionDownloadTask *> *downloadTasks;
@end


@implementation TBOSSManager

#pragma mark - 初始化

- (void)initWithConfig:(TBOSSConfig *)config {
    self.config = config;
    
    [[[self SDKClass] sharedInstance] initWithConfig:config];
}


#pragma mark - 上传

- (id)uploadFilePath:(NSString *)filePath succ:(TBUploadSucc)succ fail:(TBFail)fail {
    return [self uploadFilePath:filePath progress:nil succ:succ fail:fail];
}

- (id)uploadFilePath:(NSString *)filePath progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail {
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if (!fileData) {
        fail ? fail(2001, @"文件路径为空") : nil;
        return nil;
    }
    NSString *objectKey = [self objectKeyWithFileName:filePath.lastPathComponent];
    return [self uploadData:fileData objectKey:objectKey progress:progress succ:succ fail:fail];
}

- (void)uploadFilePath:(NSString *)filePath fileName:(NSString *)fileName succ:(TBUploadSucc)succ fail:(TBFail)fail {
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if (!fileData) {
        fail ? fail(2001, @"文件路径为空") : nil;
        return;
    }
    NSString *objectKey = fileName;
    if (self.config.objectKeyPath) {
        objectKey = [self.config.objectKeyPath stringByAppendingString:fileName];
    }
    [self uploadData:fileData objectKey:objectKey progress:nil succ:succ fail:fail];
}

- (void)uploadImage:(UIImage *)image succ:(TBUploadSucc)succ fail:(TBFail)fail {
    [self uploadImage:image progress:nil succ:succ fail:fail];
}

- (void)uploadImage:(UIImage *)image progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail {
    NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
    [self uploadFileData:fileData suffix:@"jpg" progress:progress succ:succ fail:fail];
}

- (void)uploadFileData:(NSData *)fileData suffix:(NSString *)suffix succ:(TBUploadSucc)succ fail:(TBFail)fail {
    [self uploadFileData:fileData suffix:suffix progress:nil succ:succ fail:fail];
}

- (void)uploadFileData:(NSData *)fileData suffix:(NSString *)suffix progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail {
    if (!fileData) {
        fail ? fail(2001, @"文件路径为空") : nil;
        return;
    }
    NSString *fileName = [NSString stringWithFormat:@"%ld.%@", [[NSDate date] timeIntervalSince1970] * 1000, suffix];
    NSString *objectKey = [self objectKeyWithFileName:fileName];
    [self uploadData:fileData objectKey:objectKey progress:progress succ:succ fail:fail];
}


#pragma mark - 下载

- (void)downloadRemoteURL:(NSString *)remoteURL succ:(TBDownloadSucc)succ fail:(TBFail)fail {
    if (!remoteURL.lastPathComponent) {
        fail ? fail(2003, @"远程URL对应的文件不存在") : nil;
        return;
    }
    [self downloadData:remoteURL savaPath:nil progress:nil succ:succ fail:fail];
}

- (void)downloadRemoteURL:(NSString *)remoteURL progress:(TBProgress)progress succ:(TBDownloadSucc)succ fail:(TBFail)fail {
    if (!remoteURL.lastPathComponent) {
        fail ? fail(2003, @"远程URL对应的文件不存在") : nil;
        return;
    }
    [self downloadData:remoteURL savaPath:nil progress:progress succ:succ fail:fail];
}

- (void)downloadRemoteURL:(NSString *)remoteURL savaPath:(NSString *)savaPath succ:(TBDownloadSucc)succ fail:(TBFail)fail {
    [self downloadRemoteURL:remoteURL savaPath:savaPath progress:nil succ:succ fail:fail];
}

- (void)downloadRemoteURL:(NSString *)remoteURL savaPath:(NSString *)savaPath progress:(TBProgress)progress succ:(TBDownloadSucc)succ fail:(TBFail)fail {
    if (!remoteURL) {
        fail ? fail(2003, @"远程URL对应的文件不存在") : nil;
        return;
    }
    [self downloadData:remoteURL savaPath:savaPath progress:progress succ:^(NSData * _Nonnull data) {
        NSError *err;
        [data writeToFile:savaPath options:NSDataWritingAtomic error:&err];
        if (err) {
            fail ? fail(2002, @"文件下载后保存出错") : nil;
        }
        else {
            succ ? succ(data) : nil;
        }
    } fail:fail];
}


#pragma mark - 取消任务

- (void)cancelRequest:(id)request {
    [[[self SDKClass] sharedInstance] cancelRequest:request];
}

- (BOOL)isCancelledOfRequest:(id)request {
    return [[[self SDKClass] sharedInstance] isCancelledOfRequest:request];
}

- (BOOL)cancelDownloadRequest:(NSString *)url {
//    return [[[self SDKClass] sharedInstance] cancelDownloadRequest:url];
    if (url.length == 0) {
        return NO;
    }
    __block BOOL isHasDownloadTask = NO;
    @synchronized (self) {
        if (self.downloadTasks.count == 0) {
            isHasDownloadTask = NO;
        }
        [self.downloadTasks enumerateObjectsUsingBlock:^(NSURLSessionDownloadTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([url hasPrefix:task.currentRequest.URL.absoluteString]) {
                [task cancel];
                if ([self.downloadTasks containsObject:task]) {
                    [self.downloadTasks removeObject:task];
                }
                isHasDownloadTask = YES;
                *stop = YES;
            }
        }];
        return isHasDownloadTask;
    }
}


#pragma mark - 其他

- (NSString *)thumbImageURLStringWithHost:(NSString *)host ratio:(NSInteger)ratio {
    return [[[self SDKClass] sharedInstance] thumbImageURLStringWithHost:host ratio:ratio];
}


#pragma mark - ===== Private Method =====

/**上传*/
- (id)uploadData:(NSData *)data objectKey:(NSString *)objectKey progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail {
    return [[[self SDKClass] sharedInstance] uploadData:data objectKey:objectKey progress:progress succ:succ fail:fail];
}

/**下载*/
- (void)downloadData:(NSString *)url savaPath:(NSString *)savaPath progress:(TBProgress)progress succ:(TBDownloadSucc)succ fail:(TBFail)fail {
//    [[[self SDKClass] sharedInstance] downloadData:url progress:progress succ:succ fail:fail];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *downloadTask = [self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress ? progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount) : nil;
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!savaPath) { //没有下载路径时设置默认路径
            NSString *basePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
                    stringByAppendingPathComponent:@"ossFile"];
            if (![[NSFileManager defaultManager] fileExistsAtPath:basePath]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            //重新设置文件路径中的文件名，防止兼容问题
            NSString *unit = @""; //文件后缀名
            NSArray *units = [url.lastPathComponent componentsSeparatedByString:@"."];
            if (units.count > 0) {
                unit = [NSString stringWithFormat:@".%@", units.lastObject];
            }
            NSString *fileName = [NSString stringWithFormat:@"%.f%@", [[NSDate date] timeIntervalSince1970]*1000, unit];
            NSString *defaultSavaPath = [basePath stringByAppendingPathComponent:fileName];
            return [NSURL fileURLWithPath:defaultSavaPath];
        }
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:savaPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            succ ? succ([NSData dataWithContentsOfURL:filePath]) : nil;
        }
        else {
            fail ? fail(error.code, error.description) : nil;
        }
        if ([self.downloadTasks containsObject:downloadTask]) {
            [self.downloadTasks removeObject:downloadTask];
        }
    }];
    [downloadTask resume];
    
    if (![self.downloadTasks containsObject:downloadTask]) {
        [self.downloadTasks addObject:downloadTask];
    }
}

/**
 设置自定义格式远程文件路径

 @param fileName 文件名称
 @return 路径
 */
- (NSString *)objectKeyWithFileName:(NSString *)fileName {
    //重新设置文件路径中的文件名，防止兼容问题
    NSString *unit = @""; //文件后缀名
    NSArray *units = [fileName componentsSeparatedByString:@"."];
    if (units.count > 0) {
        unit = [NSString stringWithFormat:@".%@", units.lastObject];
    }
    fileName = [NSString stringWithFormat:@"%.f%@", [[NSDate date] timeIntervalSince1970]*1000, unit];
    
    if (self.config.objectKeyPath) {
        return [self.config.objectKeyPath stringByAppendingString:fileName];
    }
    return fileName;
}

/// 获取业务SDK类
- (id)SDKClass {
    switch (self.config.sdkType) {
        case TBOSSSDKType_AliCloud:
            return NSClassFromString(@"TBAliOSSManager");
            break;
        case TBOSSSDKType_HuaweiCloud:
            return NSClassFromString(@"TBHuaweiOSSManager");
            break;
            
        default:
            break;
    }
}


#pragma mark - Life Cycle / Get

- (AFURLSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return _sessionManager;
}

+ (instancetype)sharedInstance {
    static TBOSSManager *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[TBOSSManager alloc] init];
    });
    return obj;
}


@end
