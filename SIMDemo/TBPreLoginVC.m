//
//  TBPreLoginVC.m
//  SIMDemo
//
//  on 2020/11/2.
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
     
     3. AppDelegate 中的配置 配置完成 再调用 SIM_loginSDK 登录账户 accountTxt 处的账号和 配置里的账号是一样的
     
     */
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    
    self.accountTxt = [[UITextField alloc]init];
    self.accountTxt.textAlignment = NSTextAlignmentCenter;
    self.accountTxt.layer.borderWidth = 1;
    self.accountTxt.layer.borderColor = [UIColor TB_colorForHex:0x27DFB0].CGColor;
    self.accountTxt.layer.cornerRadius = 23;
    self.accountTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountTxt.textColor = [UIColor TB_colorForHex:0x1D2221];
    self.accountTxt.font = Medium(16);
    self.accountTxt.tintColor = [UIColor TB_colorForHex:0x27DFB0];
    
    [self.view addSubview:self.accountTxt];
    [self.accountTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.equalTo(@46);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor TB_colorForHex:0x27DFB0];
    loginBtn.layer.cornerRadius = 20;
    loginBtn.clipsToBounds = YES;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.accountTxt.mas_bottom).offset(20);
        make.centerX.equalTo(self.accountTxt);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.equalTo(@40);
    }];
    
    UIImageView *logoImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"im_logo"]];
    logoImage.layer.cornerRadius = 12;
    logoImage.clipsToBounds = YES;
    [self.view addSubview:logoImage];
    [logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@60);
        make.centerX.equalTo(self.view);
        make.bottom.mas_equalTo(_accountTxt.mas_top).offset(-50);
    }];
}
- (void)initData{
    self.accountTxt.text = @"A_8589934615";
}
- (void)loginBtnClick:(UIButton *)sender{
    if (self.accountTxt.text.length == 0) {
        return;
    }
    SIMLoginParam *loginParam  = [[SIMLoginParam alloc]init];
    loginParam.accountId = self.accountTxt.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[SIMManager sharedInstance] SIM_loginSDKWithLoginParam:loginParam success:^(id  _Nonnull data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[TBChatManager sharedInstanced] remberCurrentUser:self.accountTxt.text];
        
        NSString *clientId = [[NSUserDefaults standardUserDefaults] valueForKey:@"clientId"];
        if ([clientId length] > 0) {
            [[SIMDeviceManager sharedInstance] report:clientId succ:^{
                NSLog(@"IMSDK -----> 上传 deviceToken：%@ 成功 ", clientId);
            } fail:^(SIMError * _Nonnull error) {
                NSLog(@"IMSDK -----> 上传 deviceToken：%@ 失败 ", clientId);
            }];
        }
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        window.rootViewController = [[TBMainTabBarController alloc] init];
    } fail:^(SIMError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"---SIM_loginSDK----%@",error);
    }];
}
- (void)registerBtnClick:(id)sender{
    
}
@end
