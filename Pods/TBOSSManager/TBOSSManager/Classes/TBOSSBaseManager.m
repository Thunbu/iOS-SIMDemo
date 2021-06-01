//
//  TBOSSBaseManager.m
//  TBOSSManager
//
//  Created by changxuanren on 2021/3/11.
//

#import "TBOSSBaseManager.h"

@implementation TBOSSBaseManager

#pragma mark - 上传

/**上传*/
- (id)uploadData:(NSData *)data objectKey:(NSString *)objectKey progress:(TBProgress)progress succ:(TBUploadSucc)succ fail:(TBFail)fail {
    return nil;
}


#pragma mark - 下载

- (void)downloadData:(NSString *)url progress:(TBProgress)progress succ:(TBDownloadSucc)succ fail:(TBFail)fail {
    
}


#pragma mark - 取消任务

- (void)cancelRequest:(id)request {
    
}

- (BOOL)isCancelledOfRequest:(id)request {
    return NO;
}

- (BOOL)cancelDownloadRequest:(NSString *)url {
    return NO;
}


#pragma mark - 初始化

- (void)initWithConfig:(TBOSSConfig *)config {
    self.config = config;
}


#pragma mark - Life Cycle / Get

+ (instancetype)sharedInstance {
    static TBOSSBaseManager *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[TBOSSBaseManager alloc] init];
    });
    return obj;
}


@end
