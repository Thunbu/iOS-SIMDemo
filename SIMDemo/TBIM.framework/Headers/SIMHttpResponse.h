//
//  HttpResponse.h
//  Geely
//
//  Created by yangfan on 2018/6/20.
//  Copyright © 2017年 Geely. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SIMHttpResponse : NSObject

@property(nonatomic, assign) NSInteger code;///< 200000为成功，其他为失败

@property(nonatomic, copy) NSString *message;///< 信息

@property(nonatomic, copy) id data; ///< 信息流

@end
