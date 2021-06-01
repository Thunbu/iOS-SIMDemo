//
//  TBSendMessageModel.h
//  SIMDemo
//
//  on 2020/11/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBSendMessageModel : NSObject

@property(nonatomic, assign)SIMMsgType messageType; 
@property(nonatomic, copy)NSString * _Nullable message; // 文本消息时有效

//上传图片
@property(nonatomic, copy)NSString *urlPath; // 图片的远程路径
@property(nonatomic, strong)NSData *imageData;
@property(nonatomic, strong)UIImage *upImage;

//上传视频
@property(nonatomic, copy)NSString *videPath;
@property(nonatomic, copy)NSString *coverPath;

// 上传文件
@property(nonatomic, copy)NSString *fileRemoteUrl;
@property(nonatomic, assign)CGFloat fileSize;
@property(nonatomic, copy)NSString *displayName;
@end

NS_ASSUME_NONNULL_END
