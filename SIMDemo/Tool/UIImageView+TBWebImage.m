//
//  UIImageView+TBWebImage.m
//  SIMDemo
//
//  on 2021/1/29.
//

#import "UIImageView+TBWebImage.h"

NSString const *TB_UserTaskDictionary = @"TB_UserTaskDictionary";

@implementation UIImageView (TBWebImage)

- (NSMutableDictionary *)TB_UserTaskDictionary{
    return objc_getAssociatedObject(self, &TB_UserTaskDictionary);
}

- (void)setTB_UserTaskDictionary:(NSMutableDictionary *)dic{
    objc_setAssociatedObject(self, &TB_UserTaskDictionary, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tb_setImageWithUserId:(NSString *)userId placeholder:(UIImage *)placeImage{
    if (!userId || [userId isEqualToString:@""]){
        return;
    }
    
    // 暂时只做 本地磁盘缓存
    NSString *cacheUrl = [[NSUserDefaults standardUserDefaults] valueForKey:userId];
    if (cacheUrl){
        [self sd_setImageWithURL:[NSURL URLWithString:cacheUrl] placeholderImage:placeImage];
        return;
    }
   [[SIMAddressBookManager shareManager] TB_UserInfo:@{@"userId": userId} complection:^(id resultObject, NSError *error) {
        if (error){
            return;
        }
        if (resultObject[@"data"] && resultObject[@"data"][@"avatar"]){
            NSString *userAvatar = resultObject[@"data"][@"avatar"];
            [self sd_setImageWithURL:[NSURL URLWithString:userAvatar] placeholderImage:placeImage];
            [[NSUserDefaults standardUserDefaults] setValue:userAvatar forKey:userId];
        }
    }];
    
}
@end
