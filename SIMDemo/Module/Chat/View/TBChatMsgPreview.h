//
//  TBChatMsgPreview.h
//  SIMDemo
//
//  Created by xiaobing on 2020/11/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBChatMsgPreview : UIView

- (void)showImageWithMessages:(NSArray <SIMMessage *>*)msgs inView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
