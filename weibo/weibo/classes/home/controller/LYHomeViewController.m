//
//  LYHomeViewController.m
//  weibo
//
//  Created by 耿启富 on 2018/12/31.
//  Copyright © 2018年 sirius.com. All rights reserved.
//

#import "LYHomeViewController.h"
#import "UIBarButtonItem+Item.h"
#import "LYHomeTitle.h"
#import "LYCover.h"
#import "LYPopMenu.h"
#import "LYMenuViewController.h"
#import "LYOneViewController.h"

@interface LYHomeViewController ()<LYCoverDelegate>

@property (nonatomic, weak) LYHomeTitle *titleButton;

@property (nonatomic, strong) LYMenuViewController *menu;

@end

@implementation LYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setUpNavgationBar];
    
}

#pragma mark - 设置导航条内容
- (void)setUpNavgationBar
{
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    // titleView
    LYHomeTitle *titleButton = [LYHomeTitle buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(menuTitleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
}

#pragma mark - 点击标题菜单按钮
-(void)menuTitleClick:(UIButton*)button
{
    button.selected = !button.selected;
    
    // 弹出蒙板
    LYCover *cover = [LYCover show];
    cover.delegate = self;
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    LYPopMenu *menu = [LYPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.menu.view;
}

- (void)coverDidClick:(LYCover *)cover
{
    // 隐藏pop菜单
    [LYPopMenu hide];
    
    _titleButton.selected = NO;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (void)friendsearch
{
    NSLog(@"%s",__func__);
}

- (void)pop
{
    //创建新的控制器
    LYOneViewController *one = [[LYOneViewController alloc]init];
    
    //隐藏tabBar
    // 前提条件，隐藏系统自带的tabBar
    one.hidesBottomBarWhenPushed = YES;
    
    //跳转到新的控制器
    [self.navigationController pushViewController:one animated:YES];
}

@end
