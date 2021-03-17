//
//  GLPreLoginVC.m
//  SIMDemo
//
//  Created by xiaobing on 2020/11/2.
//

#import "TBPreLoginVC.h"
#import "TBMainTabBarController.h"

@interface TBPreLoginVC ()

@property(nonatomic, strong)UITextField *accountTxt;

@end

@implementation TBPreLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initData];
}
- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.accountTxt = [[UITextField alloc]init];
    self.accountTxt.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.accountTxt];
    [self.accountTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@300);
        make.height.equalTo(@60);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.accountTxt.mas_bottom).offset(20);
        make.centerX.equalTo(self.accountTxt);
        make.width.equalTo(@60);
        make.height.equalTo(@40);
    }];
}
- (void)initData{
    self.accountTxt.text = @"A_8589934644";
}
- (void)loginBtnClick:(UIButton *)sender{
    if (self.accountTxt.text.length == 0) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    @weakify(self);
    [TBNetReqManager POSTRequestWithUrl:@"http://10.86.59.79:8367/home/userSig" params:@{@"userId": self.accountTxt.text, @"terminalCode": @"0",} block:^(id  _Nonnull resultObject, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        @strongify(self);
        if (!self) {
            return;
        }
        if (!error) {
            //登录IM
            SIMLoginParam *param = [SIMLoginParam new];
            param.identifier = self.accountTxt.text;
            param.userSig = (NSString *)resultObject;
            param.relatedUsers = @[@{@"appId":@"1000000217", @"userId":self.accountTxt.text}];
            
            [[SIMManager sharedInstance] login:param succ:^(id  _Nonnull data) {
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                window.rootViewController = [[TBMainTabBarController alloc] init];
            } fail:^(SIMError * _Nonnull error) {
                
            }];
        }
    }];
}
@end
