//
//  TBNetReqManager.m
//  SIMDemo
//
//  Created by changxuanren on 2020/10/30.
//

#import "TBNetReqManager.h"

@implementation TBHttpResponse

@end



@implementation TBNetReqManager

+ (void)GETRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params block:(JSONResultBlock)resultblock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlString parameters:params headers:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TBHttpResponse *responseData = [TBHttpResponse yy_modelWithDictionary:responseObject];
        if (responseData.code == 200000) {
            resultblock ? resultblock(responseData.data, nil) : nil;
        }
        else {
            resultblock ? resultblock(nil, NSError.new) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultblock ? resultblock(nil, error) : nil;
    }];
}

+ (void)POSTRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params block:(JSONResultBlock)resultblock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:params headers:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TBHttpResponse *responseData = [TBHttpResponse yy_modelWithDictionary:responseObject];
        if (responseData.code == 200000) {
            resultblock ? resultblock(responseData.data, nil) : nil;
        }
        else {
            resultblock ? resultblock(nil, NSError.new) : nil;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultblock ? resultblock(nil, error) : nil;
    }];
}

@end
