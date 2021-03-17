//
//  TBSingleTxtCell.h
//  SIMDemo
//
//  Created by xiaobing on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 只有单条文本 例如进群 通知 撤回消息通知 等
@interface TBSingleTxtCell : UITableViewCell


- (void)configTextMessage:(SIMSession *)session chatMessage:(SIMMessage *)message;
@end

NS_ASSUME_NONNULL_END
