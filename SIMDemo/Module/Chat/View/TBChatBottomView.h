//
//  TBChatBottomView.h
//  SIMDemo
//
//  Created by xiaobing on 2020/11/2.
//

#import <UIKit/UIKit.h>

@class TBSendMessageModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^sureSend)(TBSendMessageModel *);
typedef void (^bottomFrameChange)(CGFloat);

@interface TBChatBottomView : UIView

@property(nonatomic, copy)sureSend sendMessage;
@property(nonatomic, copy)bottomFrameChange frameChange;

// 同时配置底部 显示按钮
- (id)initWithFrame:(CGRect)frame defaultTxt:(NSString *)dTxt;

// 底部按钮失去第一响应
- (void)inactiveBottomView;

// 清除文本内容
- (void)clearMessageTxt;

// 配置底部操作
- (void)configBottomActions:(NSArray *)normalImgArr highImgs:(NSArray *)hImgArr;
@end



NS_ASSUME_NONNULL_END
