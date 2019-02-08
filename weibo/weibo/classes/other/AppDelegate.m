//
//  AppDelegate.m
//  weibo
//
//  Created by 耿启富 on 2018/12/30.
//  Copyright © 2018年 sirius.com. All rights reserved.
//

#import "AppDelegate.h"
#import "LYTabBarController.h"
#import "LYNewFeatureController.h"
#import "LYOAuthViewController.h"
#import "LYAccount.h"
#import "LYAccountTool.h"
#import "LYRootVcTool.h"
#import <AVFoundation/AVFoundation.h>

#define LYVersionKey @"version"

@interface AppDelegate ()
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%s",__func__);
    
    //注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    // 创建窗口
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 判断下有没有授权
    if ([LYAccountTool account]) { // 已经授权
        // 选择根控制器
        [LYRootVcTool chooseRootViewController:self.window];
        
    }else{ // 进行授权
        LYOAuthViewController *oauthVc = [[LYOAuthViewController alloc] init];
        
        // 设置窗口的根控制器
        self.window.rootViewController = oauthVc;
        
    }
    
    //创建授权界面
//    LYOAuthViewController *oauth = [[LYOAuthViewController alloc]init];
//    self.window.rootViewController = oauth;
    
    
//    //1.获取当前版本号
//    NSString *currentVerison = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//    //2.获取上一次版本号
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:LYVersionKey];
//    //3.判断当前是否有新的版本，如果有新特性，进入新特性界面
//    if ([currentVerison isEqualToString:lastVersion]) {//没有最新版本号
//
//        //创建自定义tabbarcontroller
//
//        LYTabBarController *tabBarVc = [[LYTabBarController alloc]init];
//        // 设置窗口的根控制器
//
//        self.window.rootViewController = tabBarVc;
//
//    }else{//有最新版本号，进入新特性界面
//        LYNewFeatureController *newFeature = [[LYNewFeatureController alloc]init];
//        //保存当前版本
//        [[NSUserDefaults standardUserDefaults] setObject:currentVerison forKey:LYVersionKey];
//        // 设置窗口的根控制器
//
//        self.window.rootViewController = newFeature;
//    }
    
    // 显示窗口
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"爸比我要喝奶奶.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    // 无限播放
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    // 开启一个后台任务,时间不确定，优先级比较低，假如系统要关闭应用，首先考虑此task
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        // 当后台任务结束的时候调用
        [application endBackgroundTask:ID];
        
    }];
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
