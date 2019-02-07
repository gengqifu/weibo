//
//  LYOAuthViewController.m
//  weibo
//
//  Created by 耿启富 on 2019/2/7.
//  Copyright © 2019年 sirius.com. All rights reserved.
//

#import "LYOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "LYAccount.h"
#import "LYAccountTool.h"
#import "LyRootVcTool.h"

#define LYAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define LYClient_id     @"2288560777"
#define LYRedirect_uri  @"http://www.baidu.com"
#define LYClient_secret @"b3d6a0b3cd38fa35dd2caff7f1e6296b"

@interface LYOAuthViewController ()<UIWebViewDelegate>

@end

@implementation LYOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 展示登陆的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    // 加载网页
    // 一个完整的URL:基本URL + 参数
    // https://api.weibo.com/oauth2/authorize?client_id=&redirect_uri=
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"2288560777";
    NSString *redirect_uri = @"http://www.baidu.com";
    
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    // 创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
}
#pragma mark -UIWebView代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
//  webview加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

// 当Webview需要加载一个请求的时候，就会调用这个方法，询问下是否请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    // 获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) { // 有code=
        
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        NSLog(@"this is code%@",code);
        [self accessTokenWithCode:code];
        // 不会去加载回调界面
        return NO;
    }
    
    return YES;
}

#pragma mark - 换取accessToken
- (void)accessTokenWithCode:(NSString *)code
{
    // 发送Post请求
    
    // 创建请求管理者:请求和解析
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = LYClient_id;
    params[@"client_secret"] = LYClient_secret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = LYRedirect_uri;
    
    // 发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) { // 请求成功的时候调用
        NSLog(@"%@",responseObject);
        LYAccount *account = [LYAccount accountWithDict:responseObject];
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [LYAccountTool saveAccount:account];
        // 进入主页或者新特性,选择窗口的根控制器
        [LYRootVcTool chooseRootViewController:LYKeyWindow];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) { // 请求失败的时候调用
        NSLog(@"%@",error);
    }];
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
