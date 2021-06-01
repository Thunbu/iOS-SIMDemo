//
//  TBHuaweiOSSManager.m
//  TBOSSManager
//
//  Created by changxuanren on 2021/3/10.
//

#import "TBHuaweiOSSManager.h"
#import <OBS/OBS.h>
#import "TBOSSConfig.h"

@interface TBHuaweiOSSManager ()

@property (nonatomic, strong) OBSClient *client;
/// 下载请求数组
@property (nonatomic, strong) NSMutableArray<OBSGetObjectToDataRequest *> *downloadRequests;

@end


@implementation TBHuaweiOSSManager

#pragma mark - 上传

- (id)uploadData:(NSData *)data objectKey:(NSString *)objectKey progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail {
    OBSPutObjectWithDataRequest *put = [[OBSPutObjectWithDataRequest alloc] initWithBucketName:(self.config.bucketName ? self.config.bucketName : @"") objectKey:objectKey uploadData:data];
    //上传进度回调
    put.uploadProgressBlock = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
        progress ? progress(totalBytesSent, totalBytesExpectedToSend) : nil;
    };
    //启动上传任务
    [self.client putObject:put completionHandler:^(OBSPutObjectResponse *response, NSError *error) {
        if (!error) {
            NSMutableString *result = [NSMutableString stringWithString:(self.config.outputURL ? self.config.outputURL : @"")];
            NSString *http = @"https://";
            if ([result containsString:http]) {
                [result insertString:[NSString stringWithFormat:@"%@.", (self.config.bucketName ? self.config.bucketName : @"")] atIndex:http.length];
            }
            succ ? succ([result stringByAppendingFormat:@"/%@", put.objectKey]) : nil;
        }
        else {
            NSInteger errorCode = error.code;
            fail ? fail(errorCode, error.description) : nil;
        }
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

    OBSGetObjectToDataRequest *request = [[OBSGetObjectToDataRequest alloc] initWithBucketName:(self.config.bucketName ? self.config.bucketName : @"") objectKey:objectKey];
    //下载进度回调
    request.downloadProgressBlock = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        progress ? progress(totalBytesWritten, totalBytesExpectedToWrite) : nil;
    };
    if (![self.downloadRequests containsObject:request]) {
        [self.downloadRequests addObject:request];
    }
    //启动下载任务
    [self.client getObject:request completionHandler:^(OBSGetObjectResponse *response, NSError *error) {
        if (!error) {
            NSLog(@"download object success!");
            succ ? succ(response.objectData) : nil;
        }
        else {
            NSLog(@"download object failed, error: %@", error);
            NSInteger errorCode = error.code;
            fail ? fail(errorCode, error.description) : nil;
        }
        if ([self.downloadRequests containsObject:request]) {
            [self.downloadRequests removeObject:request];
        }
    }];
}


#pragma mark - 取消任务

- (void)cancelRequest:(id)request {
    if ([request isKindOfClass:[OBSPutObjectWithDataRequest class]]) {
        OBSPutObjectWithDataRequest *putRequest = (OBSPutObjectWithDataRequest *)request;
        [putRequest cancel];
    }
    else if ([request isKindOfClass:[OBSGetObjectToDataRequest class]]) {
        OBSGetObjectToDataRequest *getRequest = (OBSGetObjectToDataRequest *)request;
        [getRequest cancel];
    }
}

- (BOOL)isCancelledOfRequest:(id)request {
    if ([request isKindOfClass:[OBSPutObjectWithDataRequest class]]) {
        OBSPutObjectWithDataRequest *putRequest = (OBSPutObjectWithDataRequest *)request;
        return putRequest.isCancelled;
    }
    else if ([request isKindOfClass:[OBSGetObjectToDataRequest class]]) {
        OBSGetObjectToDataRequest *getRequest = (OBSGetObjectToDataRequest *)request;
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
        [self.downloadRequests enumerateObjectsUsingBlock:^(OBSGetObjectToDataRequest  *_Nonnull request, NSUInteger idx, BOOL * _Nonnull stop) {
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
    return [NSString stringWithFormat:@"%@?x-image-process=image/resize,l_%.2d", host, ratio];
}


#pragma mark - 初始化

- (void)initWithConfig:(TBOSSConfig *)config {
    self.config = config;
    [self setupClient];
}

- (void)setupClient {
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
            return;
        }
        NSDictionary *object = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        if (error) {
            return;
        }
        NSString *code = [object objectForKey:@"code"];
        if (code && [code integerValue] == 200000) {
            //对服务器返回的token进行AES解密
            NSDictionary *resultDic = ((NSDictionary *)[object objectForKey:@"data"]).mutableCopy;
            NSString *accessKey = [resultDic objectForKey:@"access"];
            NSString *secretKey = [resultDic objectForKey:@"secret"];
            NSString *securitytoken = [resultDic objectForKey:@"securitytoken"];

            // 初始化身份验证
            OBSStaticCredentialProvider *credential = [[OBSStaticCredentialProvider alloc] initWithAccessKey:accessKey secretKey:secretKey];
            credential.securityToken = securitytoken;
            // 初始化服务配置
            OBSServiceConfiguration *conf = [[OBSServiceConfiguration alloc] initWithURLString:(self.config.outputURL ? self.config.outputURL : @"") credentialProvider:credential];
            // 初始化client
            self.client = [[OBSClient alloc] initWithConfiguration:conf];
        }
        else {
            return;
        }
    }];
    [task resume];
}


#pragma mark - Life Cycle / Get

+ (instancetype)sharedInstance {
    static TBHuaweiOSSManager *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[TBHuaweiOSSManager alloc] init];
    });
    return obj;
}


@end
