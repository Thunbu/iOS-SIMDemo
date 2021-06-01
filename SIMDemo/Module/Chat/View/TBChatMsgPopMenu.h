//
//  TBChatMsgPopMenu.h
//  SIMDemo
//
//  on 2020/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum TBChatPopMenuType: NSUInteger {
    TBChatPopMenuTypeDelete,
    TBChatPopMenuTypeCopy,
    TBChatPopMenuTypeForward,
} TBChatPopMenuType;

@interface TBChatMsgPopMenu : NSObject

+ (instancetype)sharedMenu;
- (void)tb_showWithTitles:(NSArray <NSString *>*)menus inView:(UIView *)view actionClick:(void(^)(TBChatPopMenuType))action;

@end

NS_ASSUME_NONNULL_END
