//
//  LCNetViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/4/17.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCNetViewController.h"
#import "Reachability.h"

@interface LCNetViewController ()

@end

@implementation LCNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

/// 监听网络状态
- (IBAction)monitoringNetworkStatusClick:(id)sender {

    NetworkStatus status = [self getNetworkStatus];
    if (status == ReachableViaWiFi || status == ReachableViaWWAN) { // 有网

        NSLog(@"有网络");

    }else { 

        NSLog(@"没网络");
    }
}

/// 获取当前网络状态
- (NetworkStatus)getNetworkStatus {

    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    return internetStatus;
}

@end
