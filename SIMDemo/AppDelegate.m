//
//  AppDelegate.m
//  SIMDemo
//
//  Created by changxuanren on 2020/10/22.
//

#import "AppDelegate.h"
#import "TBPreLoginVC.h"
#import "TBSessionManager.h"

@interface AppDelegate ()<SIMListener,SIMConnListener>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    //注册消息监听，用于接收消息
    [[SIMListenerManager sharedInstance] registListenerServices:self];
    
    //初始化IMSDK
    SIMSdkConfig *config = [[SIMSdkConfig alloc] init];
    config.sdkAppId = @"1000000217"; // 用户申请的appid
    config.accountId = @"A_8589934620"; // 账号ID
    config.budleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];; // bundleidentifier
    [[SIMManager sharedInstance] initSdk:config];

    UINavigationController *loginNav= [[UINavigationController alloc]initWithRootViewController:[TBPreLoginVC new]];
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = loginNav;
    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - SIMListener

#pragma mark -消息
/**
 新消息回调通知

 @param msg SIMMessage 类型
 */
- (void)onReceivedMessage:(SIMMessage *)msg {
    NSLog(@"SDK 收到消息：%@", [msg yy_modelToJSONObject]);
    
    //通知到会话列表
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onReceivedMessage" object:msg];
    
    //通知到会话
    [[TBChatManager sharedInstanced] receiveMessage:msg];
}

@end
