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

#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "LYStatus.h"
#import "LYAccountTool.h"
#import "LYAccount.h"
#import "LYHttpTool.h"
#import "LYStatusTool.h"

@interface LYHomeViewController ()<LYCoverDelegate>

@property (nonatomic, weak) LYHomeTitle *titleButton;

@property (nonatomic, strong) LYMenuViewController *menu;

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation LYHomeViewController

- (NSMutableArray *)statuses
{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

-(LYMenuViewController*)menu
{
    if (_menu==nil) {
        _menu = [[LYMenuViewController alloc]init];
    }
    return _menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条内容
    [self setUpNavgationBar];
    
    //添加下拉刷新控件，请求最新微博数据
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
    [self.tableView.mj_header beginRefreshing];
    
    //添加上拉刷新旧微博控件
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    
    //[self loadNewStatus];
}

#pragma mark - 请求最新的微博
- (void)loadNewStatus
{
    NSString *sinceId = nil;
    if (self.statuses.count) { // 有微博数据，才需要下拉刷新
        
        sinceId = [self.statuses[0] idstr];
    }
    
    [LYStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        // 结束下拉刷新
        [self.tableView.mj_header endRefreshing];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // 把最新的微博数插入到最前面
        [self.statuses insertObjects:statuses atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 请求更多旧的微博
- (void)loadMoreStatus
{
    NSString *maxIdStr = nil;
    if (self.statuses.count) { // 有微博数据，才需要下拉刷新
        long long maxId = [[[self.statuses lastObject] idstr] longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    [LYStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        
        // 结束上拉刷新
        [self.tableView.mj_footer endRefreshing];
        // 把数组中的元素添加进去
        [self.statuses addObjectsFromArray:statuses];
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // Configure the cell...
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    LYStatus *status =self.statuses[indexPath.row];
    cell.textLabel.text =status.user.name;
    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    cell.detailTextLabel.text = status.text;
    return cell;
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

#pragma mark - refresh
-(void)refresh
{
    [self.tableView.mj_header beginRefreshing];
    NSLog(@"in to refreash");
}

@end
