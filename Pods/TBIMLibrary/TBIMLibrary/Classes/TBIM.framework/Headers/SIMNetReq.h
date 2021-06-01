//
//  NBNetReq.h
//  Geely
//
//  on 2018/6/20.
//

#import <AFNetworking/AFNetworking.h>
#import "SIMHttpResponse.h"

typedef NS_ENUM(NSUInteger, GLRequestSerializer) {
    /** 默认类型 */
    GLRequestSerializerWithDefault = 0,
    /** JSON类型 */
    GLRequestSerializerWithJSON
};
typedef NS_ENUM(NSUInteger, GLResponseSerializer) {
    /** 默认类型 */
    GLResponseSerializerWithDefault = 0,
    /** JSON类型 */
    GLResponseSerializerWithJSON,
    GLResponseSerializerWithImage
};

typedef NS_ENUM(NSUInteger, NBNetResponseCode) {
    NBNetResponseCodeForDefault = 502,		// 默认错误
    NBNetResponseCodeForNetInterrupt = 580,	// 网络中断（当前无任何网络连接）
    NBNetResponseCodeForParseError = 581,	// 数据解析错误
    NBNetResponseCodeForUnknow = 599		// 其他未知错误
};

typedef void (^JSONResultBlock)(id resultObject, NSError *error);

@interface SIMNetReq : NSObject

@property(nonatomic, strong, readonly) NSURL *baseUrl;///< 基地址

#pragma mark - =============== Public Method ===============

/** 项目内部的接口请求基础类 */
+ (SIMNetReq *)shareInstance;

/** 取消所有请求 */
- (void)cancelAllRequest;

/**
 * 根据URL地址取消请求
 * @param url URL地址 （可以是绝对地址，也可以是path）
 */
- (void)cancelRequestWithURL:(NSString *)url;

/**
 * 根据请求任务取消请求
 * @param task  请求任务
 */
- (void)cancelRequestWithTask:(NSURLSessionTask *)task;

/**
 返回当前网络状态

 @return 2-3G/4G/Wifi/无网络等
 */
- (AFNetworkReachabilityStatus)currentNetStatus;

#pragma mark =============== 正式获取服务器数据 ===============

/**! 警告：项目使用POST方式传输数据，GET方式不是特殊情况不使用
 * 用GET方式创建一个`NSURLSessionDataTask`请求
 * @param requestDescription 文字描述
 * @param path 路径
 * @param params 参数
 * @param modelClass 解析类
 * @param resultblock 回调
 * @return 当前请求任务(可通过resume启动和回复、cancel取消、suspend挂起)
 */
- (NSURLSessionDataTask *)GET:(NSString *)requestDescription
                    routePath:(NSString *)path
                       params:(NSDictionary *)params
                   parseClass:(Class)modelClass
                    headerField:(NSDictionary *)headerField
                        block:(JSONResultBlock)resultblock;

/**
 * GET请求外部网址(非C3应用内部基地址)
 */
- (NSURLSessionDataTask *)GETExternalURL:(NSString *)requestDescription
                               routePath:(NSString *)path
                                  params:(NSDictionary *)params
                                   block:(JSONResultBlock)resultblock;

/**
 * GET请求外部网址(非C3应用内部基地址)
 */
- (NSURLSessionDataTask *)GETExternalURL:(NSString *)requestDescription
                               routePath:(NSString *)path
                                  params:(NSDictionary *)params
                       requestSerializer:(GLRequestSerializer)requestSerializer
                      responseSerializer:(GLResponseSerializer)responseSerializer
                                   block:(JSONResultBlock)resultblock;

/**
 * 用POST方式创建一个`NSURLSessionDataTask`请求
 * @param requestDescription 请求文字描述
 * @param path 路径
 * @param params 请求参数
 * @param modelClass 解析类
 * @param resultblock 返回回调
 * @return 当前请求任务(可通过resume启动和回复、cancel取消、suspend挂起)
 */
- (NSURLSessionDataTask *)POST:(NSString *)requestDescription
                     routePath:(NSString *)path
                        params:(NSDictionary *)params
                    parseClass:(Class)modelClass
                   headerField:(NSDictionary *)headerField
                         block:(JSONResultBlock)resultblock;

/**
 * POST请求外部网址(非C3应用内部基地址)
 */
- (NSURLSessionDataTask *)POSTExternalURL:(NSString *)requestDescription
                                routePath:(NSString *)path
                                   params:(NSDictionary *)params
                                    block:(JSONResultBlock)resultblock;

/**
 * POST请求外部网址(非C3应用内部基地址)
 */
- (NSURLSessionDataTask *)POSTExternalURL:(NSString *)requestDescription
                                routePath:(NSString *)path
                                   params:(NSDictionary *)params
                        requestSerializer:(GLRequestSerializer)requestSerializer
                       responseSerializer:(GLResponseSerializer)responseSerializer
                                    block:(JSONResultBlock)resultblock;

/**
 * 用PUT方式创建一个`NSURLSessionDataTask`请求
 * @param requestDescription 请求文字描述
 * @param path 路径
 * @param params 请求参数
 * @param modelClass 解析类
 * @param resultblock 返回回调
 * @return 当前请求任务(可通过resume启动和回复、cancel取消、suspend挂起)
 */
- (NSURLSessionDataTask *)PUT:(NSString *)requestDescription
                    routePath:(NSString *)path
                       params:(NSDictionary *)params
                   parseClass:(Class)modelClass
                  headerField:(NSDictionary *)headerField
                        block:(JSONResultBlock)resultblock;

/**
 * 用DELETE方式创建一个`NSURLSessionDataTask`请求
 * @param requestDescription 请求文字描述
 * @param path 路径
 * @param params 请求参数
 * @param modelClass 解析类
 * @param resultblock 返回回调
 * @return 当前请求任务(可通过resume启动和回复、cancel取消、suspend挂起)
 */
- (NSURLSessionDataTask *)DELETE:(NSString *)requestDescription
                    routePath:(NSString *)path
                       params:(NSDictionary *)params
                   parseClass:(Class)modelClass
                  headerField:(NSDictionary *)headerField
                        block:(JSONResultBlock)resultblock;
@end
