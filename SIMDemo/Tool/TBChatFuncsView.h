//
//  TBChatFuncsView.h
//  SIMDemo
//
//  on 2021/1/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FuncBtnClick) (NSInteger, NSString *);

@interface TBChatFuncsView : UIView


@property(nonatomic, copy)FuncBtnClick funcBtnClick;

- (void)configFuncs:(NSArray *)titles images:(NSArray *)imgs;
@end

NS_ASSUME_NONNULL_END
