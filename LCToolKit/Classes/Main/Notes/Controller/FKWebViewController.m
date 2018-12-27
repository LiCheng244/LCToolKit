//
//  LSWebViewManager.m
//  LSSDK_DEV
//
//  Created by LiCheng on 2017/8/28.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "FKWebViewController.h"
#import <WebKit/WebKit.h>

@interface FKWebViewController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView      *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView  *errorView;

@end

@implementation FKWebViewController


#pragma mark - ------ 生命周期 ------


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"LiCheng 博客";

    self.view.backgroundColor = [UIColor whiteColor];

    [self setupWebView];
    [self setupProgressView];
}

-(void)fk_navigationBar:(UINavigationBar *)navigationBar didSelectedBackItem:(UINavigationItem *)item {

    if ([self.webView canGoBack]) {
        [self.webView goBack];

    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - ------ UI布局 ------
/// 设置进度条
- (void)setupProgressView {

    if (!self.progressView) {

        self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        self.progressView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2);
        self.progressView.trackTintColor    = [UIColor clearColor];
        self.progressView.progressTintColor = [UIColor greenColor];
        [self.view addSubview:self.progressView];
    }
}

/// 设置 webView
- (void)setupWebView {

    if (!self.webView) {

        // 1. 设置网页的配置文件
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback      = YES;  // 允许在线播放
        config.selectionGranularity           = YES;  // 允许可以与网页交互，选择视图
        config.suppressesIncrementalRendering = NO;   // 是否支持记忆读取

        // 2. 创建更改数据源,允许更改网页设置
        WKUserContentController *user = [[WKUserContentController alloc] init];
        [user addScriptMessageHandler:self name:@"contactService"];     // 在线客服
        [user addScriptMessageHandler:self name:@"closeWindow"];        // 关闭窗口
        config.userContentController = user;

        // 3. 创建 webView
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-66) configuration:config];
        self.webView.allowsBackForwardNavigationGestures = NO;
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;

        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:0 context:nil];

        // 4. 加载 webView
        NSString *header = [self.webUrl substringToIndex:7];
        if (![header isEqualToString:@"http://"]) { // 不是 http

            header = [self.webUrl substringToIndex:8];
            if (![header isEqualToString:@"https://"]) { // 不是 https
                self.webUrl = [NSString stringWithFormat:@"http://%@", self.webUrl];
            }
        }
        NSLog(@"%@", self.webUrl);
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
        [self.view addSubview:self.webView];
    }
}

#pragma mark - ------ WKScriptMessageHandler 代理 ------

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {

}


#pragma mark - ------ WKNavigationDelegate 代理 ------
/// 客户端接收到服务器的响应头，根据 response 相关信息决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    decisionHandler(WKNavigationActionPolicyAllow);
}


/// 开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
}


/// 网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    self.errorView.hidden = YES;
    self.webView.hidden   = NO;
}


/// 内容加载失败
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{

    self.errorView.hidden = NO;
    self.webView.hidden   = YES;
}


/// 导航跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
}


#pragma mark - ------ WKUIDelegate 代理 ------

/// 提示框
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:message
                                                            preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的"
                                                     style:(UIAlertActionStyleCancel)
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       completionHandler();
                                                   }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


/// 确认框
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:message
                                                            preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:(UIAlertActionStyleDefault)
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       completionHandler(YES);
                                                   }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:(UIAlertActionStyleCancel)
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             completionHandler(NO);
                                                         }];

    [alert addAction:action];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - ------ 监听进度条 ------

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

    if ([keyPath isEqualToString:@"estimatedProgress"]) {

        self.progressView.progress = self.webView.estimatedProgress;

        if (self.progressView.progress == 1) {

            __weak typeof (self)weakSelf = self;

            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{

                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);

            } completion:^(BOOL finished) {

                weakSelf.progressView.hidden = YES;
                weakSelf.webView.lc_y = 0;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end

