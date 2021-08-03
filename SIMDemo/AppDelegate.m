//
//  AppDelegate.m
//  SIMDemo
//
//  on 2020/10/22.
//

#import "AppDelegate.h"
#import "TBPreLoginVC.h"
#import "TBSessionManager.h"
#import "AppDelegate+PushMessage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    //注册消息监听，用于接收消息
    [[SIMListenerManager sharedInstance] registListenerServices:[TBChatManager sharedInstanced]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eliminateLogin) name:@"TBEliminateLogin" object:nil];
    
    //初始化IMSDK
    SIMSdkConfig *config = [[SIMSdkConfig alloc] init];
    config.sdkAppId = @"1000000217"; // 用户申请的appid
    [[SIMManager sharedInstance] initSdk:config];
    
    [self registeredPush:launchOptions]; ///< 注册推送通知
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.window.backgroundColor = [UIColor whiteColor];
    [self gotoLogin];
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)gotoLogin{
    UINavigationController *loginNav= [[UINavigationController alloc]initWithRootViewController:[TBPreLoginVC new]];
    self.window.rootViewController = loginNav;
}

- (void)eliminateLogin{
    [self gotoLogin];
}


@end
