//
//  TBNetReqManager.h
//  SIMDemo
//
//  on 2020/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^JSONResultBlock)(id __nullable resultObject, NSError * __nullable error);


@interface TBHttpResponse : NSObject
@property(nonatomic, assign) NSInteger code;///< 200000为成功，其他为失败
@property(nonatomic, copy) NSString *message;///< 信息
@property(nonatomic, copy) id data; ///< 信息流
@end



@interface TBNetReqManager : NSObject

+ (void)GETRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params block:(JSONResultBlock)resultblock;

+ (void)POSTRequestWithUrl:(NSString *)urlString params:(NSDictionary *)params block:(JSONResultBlock)resultblock;

@end

NS_ASSUME_NONNULL_END
