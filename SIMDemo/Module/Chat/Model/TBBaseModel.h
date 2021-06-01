//
//  TBBaseModel.h
//  SIMDemo
//
//  on 2021/1/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBBaseModel : NSObject


@property(nonatomic,assign)NSInteger code;
@property(nonatomic,strong)id data;
@property(nonatomic,copy)NSString *message;
@property(nonatomic,assign)NSInteger success;

@end


@interface TBUserModel : TBBaseModel

@property(nonatomic, copy)NSString *userId;
@property(nonatomic, copy)NSString *userName;
@property(nonatomic, copy)NSString *account;
@property(nonatomic, copy)NSString *appId;
@property(nonatomic, copy)NSString *avatar;
@property(nonatomic, copy)NSString *createTime;
@property(nonatomic, copy)NSString *definition;
@property(nonatomic, copy)NSString *disablePush;
@property(nonatomic, copy)NSString *nicknamePy;
@property(nonatomic, copy)NSString *petName;
@property(nonatomic, copy)NSString *userNickname;
@property(nonatomic, assign)NSInteger userStatus;
@property(nonatomic, assign)BOOL isChecked;

@end


NS_ASSUME_NONNULL_END
