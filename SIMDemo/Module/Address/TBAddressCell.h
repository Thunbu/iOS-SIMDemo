//
//  TBAddressCell.h
//  SIMDemo
//
//  on 2021/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBAddressCell : UITableViewCell

- (void)configWithUser:(TBUserModel *)model;

- (void)configCheckWithUser:(TBUserModel *)model;
@end

NS_ASSUME_NONNULL_END
