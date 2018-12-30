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

@interface LYTabBarController ()

@end

@implementation LYTabBarController

+ (void)initialize
{
    // 这行代码是获取所有的tabBarItem外观标识，这样就容易把不希望改动到外观也更改了
    //  UITabBarItem *item = [UITabBarItem appearance];
    //一般采用带 self的方法，这里self就是指 YGTabBarController
    
    // 获取当前这个类下面的所有tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    
    //这里也可以用[att setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    //来设置富文本字典，两种方法都可以。
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self setUpAllChildViewController];
    
    //// 自定义tabBar
    LYTabBar *tabBar = [[LYTabBar alloc] initWithFrame:self.tabBar.frame];
    
    // 利用KVC更改readonly的属性
    [self setValue:tabBar forKeyPath:@"tabBar"];
    NSLog(@"%@---%s",self.tabBar.subviews,__func__);
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@---%s",self.tabBar.subviews ,__func__);
    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%@---%s",self.tabBar.subviews ,__func__);
    
}

#pragma mark-添加所有子控制器

-(void)setUpAllChildViewController
{
    // 管理子控制器
    
    // 首页
    UIViewController *home = [[UIViewController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"] title:@"首页"];
    home.view.backgroundColor = [UIColor greenColor];
    
    // 消息
    UIViewController *message = [[UIViewController alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    message.view.backgroundColor = [UIColor blueColor];
    
    // 发现
    UIViewController *discover = [[UIViewController alloc] init];
    [self setUpOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    discover.view.backgroundColor = [UIColor purpleColor];
    
    
    // 我
    UIViewController *profile = [[UIViewController alloc] init];
    [self setUpOneChildViewController:profile image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"] title:@"我"];
    profile.view.backgroundColor = [UIColor lightGrayColor];
    NSLog(@"---%@--%s",self.tabBar.subviews,__func__);
}

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.badgeValue = @"10";
    vc.tabBarItem.selectedImage = selectedImage;
    [self addChildViewController:vc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
