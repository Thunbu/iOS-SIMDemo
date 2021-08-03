#import "AppDelegate+PushMessage.h"
#import <AVFoundation/AVFoundation.h>
#import <GTSDK/GeTuiSdk.h>     // GetuiSdk头文件应用
// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

//个推推送
NSString *const GTAppId = @"7rT3PrBI9iA2M3J39qOFZ2";
NSString *const GTAppKey = @"FP7HanzqME6sXdExNkPRD1";
NSString *const GTAppSecret = @"STcxLB0lN78Tc8Ac0S6ZX3";

@interface AppDelegate () <GeTuiSdkDelegate, UNUserNotificationCenterDelegate>

@end


@implementation AppDelegate (PushMessage)

#pragma mark - Public

- (void)registeredPush:(NSDictionary *)launchOptions {
    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:GTAppId appKey:GTAppKey appSecret:GTAppSecret delegate:self];
    // 注册 APNs
    [self registerRemoteNotification];
}


#pragma mark - UIApplicationDelegate/UNUserNotificationCenterDelegate

// 注册远程通知成功后，会调用这个方法，把 deviceToken 返回给我们
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSLog(@"deviceToken=%@", deviceToken);
}

// 注册远程通知失败后，会调用这个方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"注册远程通知失败----%@", error.localizedDescription);
}

//在iOS 10 以前，为处理 APNs 通知点击事件，统计有效用户点击数，需在AppDelegate.m里的didReceiveRemoteNotification回调方法中调用个推SDK统计接口：
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // 将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    NSLog(@"iOS<10，didReceiveRemoteNotification：%@", userInfo);
        
    completionHandler(UIBackgroundFetchResultNewData);
}

//对于iOS 10 及以后版本，为处理 APNs 通知点击，统计有效用户点击数，需先添加 UNUserNotificationCenterDelegate，然后在AppDelegate.m的 didReceiveNotificationResponse回调方法中调用个推SDK统计接口：
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"iOS>=10，willPresentNotification：%@", notification.request.content.userInfo);
        
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发，在该方法内统计有效用户点击数
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog(@"iOS>=10，didReceiveNotification：%@", response.notification.request.content.userInfo);
    // [ GTSdk ]：将收到的APNs信息传给个推统计
        
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    completionHandler();
}
#endif


#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    //注册clientId到IM管理器
    if ([clientId length] > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:clientId forKey:@"clientId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
}


#pragma mark - Private

/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}

//- (void)unRegisterDeviceToken {
//    [[SIMDeviceManager sharedInstance] report:nil succ:^{
//        NSLog(@"IMSDK -----> 取消注册deviceToken 成功 ");
//    } fail:^(SIMError * _Nonnull error) {
//        NSLog(@"IMSDK -----> 取消注册deviceToken 失败 ");
//    }];
//}
//
//- (void)handPush:(NSDictionary *)userInfo{
//    if (!userInfo || !userInfo[@"payload"]) {
//        return;
//    }
//
//    NSString *payload = userInfo[@"payload"];
//    NSError *error = nil;
//    NSDictionary *payloadDic = [NSJSONSerialization JSONObjectWithData:[payload dataUsingEncoding:NSUTF8StringEncoding]
//                                                               options:NSJSONReadingFragmentsAllowed error:&error];
//    NSLog(@"handPush，payloadDic=%@", payloadDic);
//}


@end
