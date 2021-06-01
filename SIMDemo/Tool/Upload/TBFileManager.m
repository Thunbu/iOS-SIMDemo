//
//  TBFileManager.m
//  SIMDemo
//
//  on 2021/1/26.
//

#import "TBFileManager.h"

@implementation TBFileManager


+ (instancetype)sharedInstance{
    
    static TBFileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TBFileManager alloc]init];
        [self createTempDirectory];
    });
    return manager;
}

- (NSString *)copyToLocalWithData:(NSData *)data toPath:(NSString *)path{
    [data writeToFile:path atomically:YES];
    return path;
}

- (void)deleteFileWithPath:(NSString *)filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        NSError *error = nil;
        [manager removeItemAtPath:filePath error:&error];
        if (error){
            NSLog(@"----文件删除失败---");
        }
    }
}

/// 上传文件 存储 部分 跟目录
+ (void)createTempDirectory{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *directoryPath = [NSString stringWithFormat:@"%@/TBTempFile",documentPath];
    NSError *error;
    if (![fileManager fileExistsAtPath:directoryPath]){
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    if (error != nil){
        // 文件夹创建失败 日志记录
    }
}

- (NSString *)getCopyFilePath:(NSString *)fileName{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *directoryPath = [NSString stringWithFormat:@"%@/TBTempFile",documentPath];
    return [directoryPath stringByAppendingFormat:@"/%@", fileName];
}

- (NSString *)getDateStr{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (CGFloat)sizeWithPath:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        return -1;
    }
    NSDictionary *fileDic = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
    CGFloat filesize = 1.0 * size / 1024 / 1024;
    return filesize;
}
@end
