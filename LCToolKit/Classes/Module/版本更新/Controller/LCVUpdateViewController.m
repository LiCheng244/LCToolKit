//
//  LCVUpdateViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/4/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCVUpdateViewController.h"
#import "LCVersionUpdateManager.h"

@interface LCVUpdateViewController ()
@end

@implementation LCVUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/// 从 AppStroe 获取版本信息
- (IBAction)getVerisonInfoForAppStoreClick:(id)sender {

    [LCVersionUpdateManager versionUpdateForAppID:@"1325989446" isShowDetail:YES showController:self];
}

/// 从 服务端 获取版本更新信息
- (IBAction)getVersionInfoForServerClick:(id)sender {

    NSString *message = @"从服务端获取更新信息，可以更灵活的配置更新提醒，可以配置强更、普通更新、自定义提醒内容\nAppStore有 bug，需要去更新界面刷新才能出来新版本";
    UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:(UIAlertControllerStyleAlert)];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", @"1325989446"];
        // 跳转到url
        if (urlStr != nil) {
            NSURL *url=[NSURL URLWithString:urlStr];
            [[UIApplication sharedApplication] openURL:url];
        }
    }];

    [alertV addAction:okAction];
    [self presentViewController:alertV animated:YES completion:nil];
}

@end
