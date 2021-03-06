//
//  LCVersionUpdateManager.m
//  LCToolKit
//
//  Created by LiCheng on 2018/4/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCVersionUpdateManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation LCVersionUpdateManager


/*
 网址问题:

 在网上的博客里面都是 //:itunes.apple.com/lookup?id=你的appid
 这个 网址解析出来的东西是空的

 需要加上/cn
 //:itunes.apple.com/cn/lookup?id=你的appid
 */


+ (void)versionUpdateForAppID:(NSString *)appid
                 isShowDetail:(BOOL)isShowDetail
               showController:(UIViewController *)controller {

    // 获取网络状态
    NSString *status = [self getNetWorkStatus];

    // 只有当网络为WiFi 和 4G 的情况下 提醒更新
    if ([status isEqualToString:@"WIFI"] || [status isEqualToString:@"4G"]) {

        [self getVersionForAppID:appid isShowDetail:isShowDetail showController:controller];
    }
}


#pragma mark - ------ 从 AppStore 获取版本信息 ------
+ (void)getVersionForAppID:(NSString *)appid
             isShowDetail:(BOOL)isShowDetail
           showController:(UIViewController *)controller {


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", appid];

    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSMutableArray *arr = [responseObject objectForKey:@"results"];
        NSDictionary   *dic = arr[0];

        // 获取 appstore 信息
        NSString *newVersion   = [dic objectForKey:@"version"];      // 版本号
        NSString *newURL       = [dic objectForKey:@"trackViewUrl"]; // 程序地址
        NSString *releaseNotes = [dic objectForKey:@"releaseNotes"]; // 版本注释

        // 本地版本号
        NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

        // 版本号比较
        if (![newVersion isEqualToString:localVersion]) {// 有版本更新

            NSString *message = nil;

            if (isShowDetail) {
                message = releaseNotes;
            }else{
                message = @"赶快更新吧，第一时间体验新功能！";
            }

            UIAlertController *alertV = [UIAlertController alertControllerWithTitle:@"有新版本了！" message:message preferredStyle:(UIAlertControllerStyleAlert)];

            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 跳转到url
                if (newURL != nil) {
                    NSURL *url=[NSURL URLWithString:newURL];
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            //修改按钮颜色
            [cancelAction setValue:[UIColor brownColor] forKey:@"titleTextColor"];

            [alertV addAction:cancelAction];
            [alertV addAction:okAction];
            [controller presentViewController:alertV animated:YES completion:nil];

        } else {
            NSLog(@"已经是最新版本了");
        }


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"获取更新信息失败");
    }];
}


#pragma mark - ------ 获取当前网络状态 ------
+ (NSString *)getNetWorkStatus {

    UIApplication *app = [UIApplication sharedApplication];

    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];

    NSString *status = [[NSString alloc] init];

    int netType = 0;
    //获取到网络返回码
    for (id child in children) {

        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {

            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];

            switch (netType) {
                case 0:
                    status = @"无网络";
                    break;

                case 1:
                    status = @"2G";
                    break;

                case 2:
                    status = @"3G";
                    break;

                case 3:
                    status = @"4G";
                    break;

                case 5:
                {
                    status = @"WIFI";
                }
                    break;

                default:
                    break;
            }
        }
    }
    //根据状态选择
    return status;
}


@end
