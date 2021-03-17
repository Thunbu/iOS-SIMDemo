//
//  TBSendMessageModel.h
//  SIMDemo
//
//  Created by xiaobing on 2020/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBSendMessageModel : NSObject

@property(nonatomic, assign)SIMMsgType messageType; 
@property(nonatomic, copy)NSString * _Nullable message; // 文本消息时有效

@end

NS_ASSUME_NONNULL_END
