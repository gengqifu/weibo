//
//  LYNavigationControllerViewController.m
//  weibo
//
//  Created by 耿启富 on 2019/1/30.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYNavigationController.h"
#import "UIBarButtonItem+Item.h"

@interface LYNavigationController()<UINavigationControllerDelegate>
@property(nonatomic,strong)id popDelegate;
@end

@implementation LYNavigationController

+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

-(void)viewDidLoad
{
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}
//导航控制器跳转完成时调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        //还原滑动返回手势
        self.interactivePopGestureRecognizer.delegate=_popDelegate;
    }else{
        //实现滑动返回功能,清空滑动返回手势的代理，就能实现滑动
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
//当导航控制器即将显示的时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //获取住窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //获取tabBarViewController
    UITabBarController *tabBarVc = (UITabBarController*)keyWindow.rootViewController;
    //移除系统的UITabBarButton
    for(UIView *tabBarButton in tabBarVc.tabBar.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置非根控制器的导航条内容
    if(self.viewControllers.count !=0){
        //设置导航条左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighteds"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        
        //设置导航条右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighteds"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
    
}

-(void)backToPre
{
    [self popViewControllerAnimated:YES];
}

-(void)backToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

@end
