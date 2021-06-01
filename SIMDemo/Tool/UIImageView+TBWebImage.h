//
//  UIImageView+TBWebImage.h
//  SIMDemo
//
//  on 2021/1/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (TBWebImage)

@property(nonatomic, strong)NSMutableDictionary *TB_UserTaskDictionary;

- (void)tb_setImageWithUserId:(NSString *)userId placeholder:(UIImage *)placeImage;
@end

NS_ASSUME_NONNULL_END
