//
//  MainTabBarController.m
//  SIMDemo
//
//  on 2020/10/27.
//

#import "TBMainTabBarController.h"
#import "TBSessionController.h"
#import "TBAddressBookVC.h"

@interface TBMainTabBarController ()

@end

@implementation TBMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TBSessionController *sessionVC = [[UIStoryboard storyboardWithName:@"IMChat" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TBSessionController"];;
    sessionVC.tabBarItem.title = @"消息";
    sessionVC.tabBarItem.image = [UIImage imageNamed:@"Tab_IM"];
    sessionVC.tabBarItem.selectedImage = [UIImage imageNamed:@"Tab_IM_Selected"];
    UINavigationController *sessionNav = [[UINavigationController alloc] initWithRootViewController:sessionVC];

    TBAddressBookVC *addressVC = [[TBAddressBookVC alloc]initWithType:TBAddressBookTypeNormal];
    addressVC.view.backgroundColor = [UIColor whiteColor];
    addressVC.navigationItem.title = @"通讯录";
    addressVC.tabBarItem.title = @"通讯录";
    addressVC.tabBarItem.image = [UIImage imageNamed:@"Tab_Contact"];
    addressVC.tabBarItem.selectedImage = [UIImage imageNamed:@"Tab_Contact_Selected"];
    UINavigationController *addressNav = [[UINavigationController alloc] initWithRootViewController:addressVC];
    
    // 添加子视图到tabbar
    self.viewControllers = @[sessionNav, addressNav];
    
    for (UITabBarItem *item in self.tabBar.items) {
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }

}

@end
