//
//  TBChatVC.h
//  SIMDemo
//
//  on 2020/11/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBChatVC : UIViewController

@property(nonatomic, strong) SIMSession *currentSeeion;

- (id)initWithSession:(SIMSession *)session;
@end

NS_ASSUME_NONNULL_END
