//
//  LYRootVcTool.m
//  weibo
//
//  Created by 耿启富 on 2019/2/7.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYRootVcTool.h"
#import "LYTabBarController.h"
#import "LYNewFeatureController.h"

#define LYVersionKey @"version"

@implementation LYRootVcTool

+(void)chooseRootViewController:(UIWindow *)window{
    //1.获取当前版本号
    NSString *currentVerison = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    //2.获取上一次版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:LYVersionKey];
    //3.判断当前是否有新的版本，如果有新特性，进入新特性界面
    if ([currentVerison isEqualToString:lastVersion]) {//没有最新版本号
        
        //创建自定义tabbarcontroller
        
        LYTabBarController *tabBarVc = [[LYTabBarController alloc]init];
        // 设置窗口的根控制器
        
        window.rootViewController = tabBarVc;
        
    }else{//有最新版本号，进入新特性界面
        LYNewFeatureController *newFeature = [[LYNewFeatureController alloc]init];
        //保存当前版本
        [[NSUserDefaults standardUserDefaults] setObject:currentVerison forKey:LYVersionKey];
        // 设置窗口的根控制器
        window.rootViewController = newFeature;
    }
}

@end
