//
//  TBAliOSSManager.m
//  TBOSSManager
//
//  Created by changxuanren on 2021/3/10.
//

#import "TBAliOSSManager.h"
#import <TBAESCrypt/AESCrypt.h>
#import <AliyunOSSiOS/OSSService.h>
#import "TBOSSConfig.h"

@interface TBAliOSSManager ()

@property (nonatomic, strong) OSSClient *client;
/// 下载请求数组
@property (nonatomic, strong) NSMutableArray<OSSGetObjectRequest *> *downloadRequests;

@end


@implementation TBAliOSSManager

#pragma mark - 上传

/**上传*/
- (id)uploadData:(NSData *)data objectKey:(NSString *)objectKey progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail {
    OSSPutObjectRequest *put = [OSSPutObjectRequest new];
    put.bucketName = (self.config.bucketName ? self.config.bucketName : @"");
    put.objectKey = objectKey;
    put.uploadingData = data; //上传的NSData
    //上传进度回调
    put.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        progress ? progress(totalBytesSent, totalBytesExpectedToSend) : nil;
    };
    //启动上传任务
    OSSTask *putTask = [self.client putObject:put];
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            succ ? succ([NSString stringWithFormat:@"%@/%@", (self.config.outputURL ? self.config.outputURL : @""), put.objectKey]) : nil;
        }
        else {
            NSInteger errorCode = task.error.code + 3000; //3000-3008
            fail ? fail(errorCode, task.error.description) : nil;
        }
        return nil;
    }];
    return put;
}


#pragma mark - 下载

- (void)downloadData:(NSString *)url progress:(TBProgress)progress succ:(TBDownloadSucc)succ fail:(TBFail)fail {
    NSString *utfString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *objectKey = [[NSURL URLWithString:utfString] path];
    if ([objectKey hasPrefix:@"/"]) {
        objectKey = [objectKey substringFromIndex:1];
    }
    
    OSSGetObjectRequest *request = [OSSGetObjectRequest new];
    request.bucketName = (self.config.bucketName ? self.config.bucketName : @"");
    request.objectKey = objectKey;
    //下载进度回调
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        progress ? progress(totalBytesWritten, totalBytesExpectedToWrite) : nil;
    };
    if (![self.downloadRequests containsObject:request]) {
        [self.downloadRequests addObject:request];
    }
    //启动下载任务
    OSSTask *getTask = [self.client getObject:request];
    [getTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"download object success!");
            OSSGetObjectResult *getResult = task.result;
            succ ? succ(getResult.downloadedData) : nil;
        }
        else {
            NSLog(@"download object failed, error: %@" ,task.error);
            NSInteger errorCode = task.error.code + 3000; //3000-3008
            fail ? fail(errorCode, task.error.description) : nil;
        }
        if ([self.downloadRequests containsObject:request]) {
            [self.downloadRequests removeObject:request];
        }
        return nil;
    }];
}


#pragma mark - 取消任务

- (void)cancelRequest:(id)request {
    if ([request isKindOfClass:[OSSPutObjectRequest class]]) {
        OSSPutObjectRequest *putRequest = (OSSPutObjectRequest *)request;
        [putRequest cancel];
    }
    else if ([request isKindOfClass:[OSSGetObjectRequest class]]) {
        OSSGetObjectRequest *getRequest = (OSSGetObjectRequest *)request;
        [getRequest cancel];
    }
}

- (BOOL)isCancelledOfRequest:(id)request {
    if ([request isKindOfClass:[OSSPutObjectRequest class]]) {
        OSSPutObjectRequest *putRequest = (OSSPutObjectRequest *)request;
        return putRequest.isCancelled;
    }
    else if ([request isKindOfClass:[OSSGetObjectRequest class]]) {
        OSSGetObjectRequest *getRequest = (OSSGetObjectRequest *)request;
        return getRequest.isCancelled;
    }
    return NO;
}

- (BOOL)cancelDownloadRequest:(NSString *)url {
    if (url.length == 0) {
        return NO;
    }
    __block BOOL isHasDownloadTask = NO;
    @synchronized (self) {
        if (self.downloadRequests.count == 0) {
            isHasDownloadTask = NO;
        }
        [self.downloadRequests enumerateObjectsUsingBlock:^(OSSGetObjectRequest  *_Nonnull request, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([url hasPrefix:request.objectKey]) {
                [request cancel];
                if ([self.downloadRequests containsObject:request]) {
                    [self.downloadRequests removeObject:request];
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
    return [NSString stringWithFormat:@"%@?x-oss-process=image/resize,l_%.2d", host, ratio];
}


#pragma mark - 初始化

- (void)initWithConfig:(TBOSSConfig *)config {
    self.config = config;
    [self setupClient];
}

- (void)setupClient {
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 3; // 网络请求遇到异常失败后的重试次数
    conf.timeoutIntervalForRequest = 30; // 网络请求的超时时间
    conf.timeoutIntervalForResource = 24 * 60 * 60; // 允许资源传输的最长时间
    
    //授权访问
    id<OSSCredentialProvider> credential = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * _Nullable{
        OSSTaskCompletionSource * tcs = [OSSTaskCompletionSource taskCompletionSource];
        NSURL *url = [NSURL URLWithString:(self.config.policyEncryptURL ? self.config.policyEncryptURL : @"")];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setTimeoutInterval:30.0];
        [request setHTTPMethod:@"GET"];
        for (NSString *key in self.config.policyEncryptHeaderField.allKeys) {
            NSString *obj = [NSString stringWithFormat:@"%@", [self.config.policyEncryptHeaderField objectForKey:key]];
            [request addValue:obj forHTTPHeaderField:key];
        }
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                [tcs setError:error];
                return;
            }
            NSDictionary *object = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            if (error) {
                [tcs setError:error];
                return;
            }
            NSString *code = [object objectForKey:@"code"];
            if (code && [code integerValue] == 200000) {
                //对服务器返回的token进行AES解密
                NSDictionary *resultDic = ((NSDictionary *)[object objectForKey:@"data"]).mutableCopy;
                NSString *token = [resultDic objectForKey:@"SecurityToken"];
                if (nil != token && token.length > 0) {
                    NSString *decryptToken = [AESCrypt decryptDefault:token];
                    NSLog(@"AES decryptToken :%@",decryptToken);
                    [resultDic setValue:decryptToken forKey:@"SecurityToken"];
                }
                [tcs setResult:resultDic];
            }
            else {
                return;
            }
        }];
        [task resume];
        [tcs.task waitUntilFinished];
        if (tcs.task.error) {
            NSLog(@"get token error: %@", tcs.task.error);
            return nil;
        }
        else {
            // 返回数据是json格式，需要解析得到token的各个字段
            NSDictionary * object = (NSDictionary *)tcs.task.result;
            OSSFederationToken * token = [OSSFederationToken new];
            token.tAccessKey = [object objectForKey:@"AccessKeyId"];
            token.tSecretKey = [object objectForKey:@"AccessKeySecret"];
            token.tToken = [object objectForKey:@"SecurityToken"];
            token.expirationTimeInGMTFormat = [object objectForKey:@"Expiration"];
            NSLog(@"get token: %@", token);
            return token;
        }
    }];
    self.client = [[OSSClient alloc] initWithEndpoint:(self.config.outputURL ? self.config.outputURL : @"") credentialProvider:credential clientConfiguration:conf];
}


#pragma mark - Life Cycle / Get

+ (instancetype)sharedInstance {
    static TBAliOSSManager *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[TBAliOSSManager alloc] init];
    });
    return obj;
}


@end
