//
//  MainTabBarController.m
//  SIMDemo
//
//  Created by changxuanren on 2020/10/27.
//

#import "TBMainTabBarController.h"
#import "TBSessionController.h"

@interface TBMainTabBarController ()

@end

@implementation TBMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TBSessionController *vc1 = [[UIStoryboard storyboardWithName:@"IMChat" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"TBSessionController"];;
    vc1.tabBarItem.title = @"消息";
    vc1.tabBarItem.image = [UIImage imageNamed:@"Tab_IM"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"Tab_IM_Selected"];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];

    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor whiteColor];
    vc2.navigationItem.title = @"通讯录";
    vc2.tabBarItem.title = @"通讯录";
    vc2.tabBarItem.image = [UIImage imageNamed:@"Tab_Contact"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"Tab_Contact_Selected"];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    // 添加子视图到tabbar
    self.viewControllers = @[nav1, nav2];
    
    for (UITabBarItem *item in self.tabBar.items) {
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

@end
