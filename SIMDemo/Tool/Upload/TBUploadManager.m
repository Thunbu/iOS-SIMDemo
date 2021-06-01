//
//  TBUploadManager.m
//  SIMDemo
//
//  on 2021/1/26.
//

#import "TBUploadManager.h"

@interface TBUploadManager()

@property(nonatomic, strong)QNUploadManager *uploadManager;
@property(nonatomic, copy)NSString *domain;
@property(nonatomic, copy)NSString *token;
@end

@implementation TBUploadManager

- (id)init{
    self = [super init];
    if (self){
        self.uploadManager = [[QNUploadManager alloc]init];
    }
    return self;
}

+ (instancetype)sharedInstance{
    
    static TBUploadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TBUploadManager alloc]init];
    });
    return manager;
}

- (void)uploadWithFilePath:(NSString *)filePath progress:(QNUpProgressHandler)progress complete:(UploadComplete)complete{
    if (!filePath || [filePath isEqualToString:@""]){
        return;
    }
    NSString *token = self.token;
    NSString *domain = self.domain;
    NSString *fileName = [filePath lastPathComponent];
    QNUploadOption *option = [[QNUploadOption alloc]initWithProgressHandler:progress];
    [self.uploadManager putFile:filePath key:fileName token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",domain, fileName];
        if (complete){
            complete(info.isOK,@{@"url":urlStr});
        }
    } option:option];
}
- (void)configQiNiuUploadPolicy:(NSString *)domain token:(NSString *)token{
    self.domain = domain;
    self.token = token;
}
@end
