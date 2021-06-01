//
//  TBAddressBookVC.h
//  SIMDemo
//
//  on 2021/1/22.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TBAddressBookTypeNormal,
    TBAddressBookTypeCheck,
} TBAddressBookType;

typedef void(^SureBtnClick) (NSMutableArray *_Nonnull);

NS_ASSUME_NONNULL_BEGIN

@interface TBAddressBookVC : UIViewController

@property(nonatomic, copy)SureBtnClick sureBtnClick;

- (id)initWithType:(TBAddressBookType)type;
@end

NS_ASSUME_NONNULL_END
