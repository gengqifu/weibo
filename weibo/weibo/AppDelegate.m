//
//  AppDelegate.m
//  weibo
//
//  Created by 耿启富 on 2018/12/30.
//  Copyright © 2018年 sirius.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 为了展示效果 设置背景色为黄色
    self.window.backgroundColor = [UIColor yellowColor];
    
    // 创建tabBarViewController
    UITabBarController *tabBarVc = [[UITabBarController alloc] init];
    tabBarVc.view.backgroundColor = [UIColor redColor];
    
    // 管理子控制器
    // 首页
    UIViewController *home = [[UIViewController alloc] init];
    home.view.backgroundColor = [UIColor greenColor];
    [tabBarVc addChildViewController:home];
    
    // 消息
    UIViewController *message = [[UIViewController alloc] init];
    message.view.backgroundColor = [UIColor blueColor];
    [tabBarVc addChildViewController:message];
    
    // 发现
    UIViewController *discover = [[UIViewController alloc] init];
    discover.view.backgroundColor = [UIColor purpleColor];
    [tabBarVc addChildViewController:discover];
    
    // 我
    UIViewController *profile = [[UIViewController alloc] init];
    profile.view.backgroundColor = [UIColor lightGrayColor];
    [tabBarVc addChildViewController:profile];
    
    // 设置窗口的根控制器
    self.window.rootViewController = tabBarVc;
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
