//
//  TBPreLoginVC.m
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
    
    /**
     SDK 使用 注意事项
     1. SDK 以来如下几个框架 需要在工程pod文件中 加入
        pod 'AFNetworking'
        pod 'YYModel'
        pod 'SocketRocket'
        pod 'RealReachability'
        pod 'ReactiveCocoa', '~> 2.5'
     
     2. SDK集成过程可以将DEMO 中的 TBIM.framework 直接引入项目就好 不过demo中的只支持真机
     
     3. AppDelegate 中的配置 配置完成 再调用 TBIM_loginSDK 登录账户 accountTxt 处的账号和 配置里的账号是一样的
     
     */
}
- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.accountTxt = [[UITextField alloc]init];
    self.accountTxt.textAlignment = NSTextAlignmentCenter;
    self.accountTxt.layer.borderWidth = 1;
    self.accountTxt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.accountTxt.layer.cornerRadius = 23;
    self.accountTxt.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.accountTxt];
    [self.accountTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
        make.width.equalTo(@240);
        make.height.equalTo(@46);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
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
    self.accountTxt.text = @"A_8589934620";
}
- (void)loginBtnClick:(UIButton *)sender{
    if (self.accountTxt.text.length == 0) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[SIMManager sharedInstance] TBIM_loginSDK:^(id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[TBChatManager sharedInstanced] remberCurrentUser:self.accountTxt.text];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        window.rootViewController = [[TBMainTabBarController alloc] init];
    } fail:^(SIMError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"---TBIM_loginSDK----%@",error);
    }];
}
@end
