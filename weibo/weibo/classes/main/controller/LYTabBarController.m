//
//  LYTabBarController.m
//  weibo
//
//  Created by 耿启富 on 2018/12/30.
//  Copyright © 2018年 sirius.com. All rights reserved.
//

#import "LYTabBarController.h"
#import "UIImage+image.h"
#import "LYTabBar.h"
#import "LYHomeViewController.h"
#import "LYMessageViewController.h"
#import "LYDiscoverViewController.h"
#import "LYProfileViewController.h"
#import "LYNavigationController.h"
#import "LYUnreadTool.h"
#import "LYUnreadResult.h"

#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface LYTabBarController ()<LYTabBarDelegate>

@property(nonatomic,strong) NSMutableArray *items;

@property  (nonatomic,weak) LYHomeViewController    *home;
@property (nonatomic,weak) LYDiscoverViewController *discover;
@property (nonatomic,weak) LYMessageViewController *message;
@property (nonatomic,weak) LYProfileViewController *profile;

@end

@implementation LYTabBarController

- (NSMutableArray *)items
{
    if (_items == nil) {
        
        _items = [NSMutableArray array];
        
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self setUpAllChildViewController];
    //
    [self setUpTabBar];
    
    //  请求微博未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
    
}

#pragma mark 请求未读数
-(void)requestUnread
{
    [LYUnreadTool unreadWithSuccess:^(LYUnreadResult *result) {
        //设置首页微博未读数
        // NSLog(@"this is return result%d",result.status);
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        // NSLog(@"this is home badge%@",_home.tabBarItem.badgeValue);
        //设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        //设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        //  设置未读数总和
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 设置自定义tabBar
-(void)setUpTabBar
{
    // 自定义tabBar
    //LYTabBar *tabBar = [[LYTabBar alloc] initWithFrame:self.tabBar.frame];
    LYTabBar *tabBar = [[LYTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    // 设置代理
    tabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    NSLog(@"this is items%@",self.items);
    tabBar.items = self.items;
    
    // 添加自定义tabBar
    //[self.view addSubview:tabBar];
    [self.tabBar addSubview:tabBar];
    
    // 移除系统的tabBar
    //[self.tabBar removeFromSuperview];
}

#pragma mark - 当点击tabBar上的按钮调用
-(void)tabBar:(LYTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index ==0 && self.selectedIndex == index) {
        //点击首页刷新
        [_home refresh];
        NSLog(@"this is refresh");
    }
    self.selectedIndex = index;
}

#pragma mark-添加所有子控制器

-(void)setUpAllChildViewController
{
    // 管理子控制器
    
    // 首页
    LYHomeViewController *home = [[LYHomeViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    home.view.backgroundColor = [UIColor greenColor];
    _home = home;
    
    // 消息
    LYMessageViewController *message = [[LYMessageViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    message.view.backgroundColor = [UIColor blueColor];
    _message = message;
    
    // 发现
    LYDiscoverViewController *discover = [[LYDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    discover.view.backgroundColor = [UIColor purpleColor];
    _discover = discover;
    
    // 我
    LYProfileViewController *profile = [[LYProfileViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    profile.view.backgroundColor = [UIColor lightGrayColor];
    _profile = profile;
}


#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.badgeValue = @"10";
    vc.tabBarItem.selectedImage = selectedImage;
//    [self.items addObject:vc.tabBarItem];
//    [self addChildViewController:vc];
    
    [self.items addObject:vc.tabBarItem];
    LYNavigationController *nav = [[LYNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //移除系统的UITabBarButton
//    for(UIView *tabBarButton in self.tabBar.subviews)
//    {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            [tabBarButton removeFromSuperview];
//        }
//    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
