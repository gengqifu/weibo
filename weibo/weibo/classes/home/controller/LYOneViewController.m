//
//  LYOneViewController.m
//  weibo
//
//  Created by 耿启富 on 2019/2/3.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYOneViewController.h"
#import "LYTwoViewController.h"

@interface LYOneViewController ()

@end

@implementation LYOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)jumpToTwoController:(id)sender {
    LYTwoViewController *two = [[LYTwoViewController alloc]init];
    [self.navigationController pushViewController:two animated:YES];
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
