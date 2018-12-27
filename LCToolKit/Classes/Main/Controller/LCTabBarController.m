//
//  LCTabBarController.m
//  LCToolKit
//
//  Created by LiCheng on 2017/12/8.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCTabBarController.h"
#import "LCUserViewController.h"
#import "LCMainViewController.h"
#import "LCNavigationController.h"
#import "FKWebViewController.h"

@interface LCTabBarController ()

@end

@implementation LCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    LCUserViewController *userVC = [[LCUserViewController alloc] init];
    LCNavigationController *userNav = [LCNavigationController setupChildVC:userVC title:@"个人中心" image:@"user" selectImage:@"user_sel"];

    LCMainViewController *mainVC = [[LCMainViewController alloc] init];
    LCNavigationController *mainNav = [LCNavigationController setupChildVC:mainVC title:@"主界面" image:@"home" selectImage:@"home_sel"];

    FKWebViewController *webVC = [[FKWebViewController alloc] init];
    webVC.webUrl = @"http://www.licheng244.com";
    LCNavigationController *webNav = [LCNavigationController setupChildVC:webVC title:@"个人笔记" image:@"home" selectImage:@"home_sel"];

    [self addChildViewController:mainNav];
    [self addChildViewController:webNav];
    [self addChildViewController:userNav];
}

+ (void)initialize {

    NSMutableDictionary *normal = [NSMutableDictionary dictionary];
    normal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    normal[NSForegroundColorAttributeName] = [UIColor lc_hexCodeColor:@"bfbfbf"];

    NSMutableDictionary *select = [NSMutableDictionary dictionary];
    select[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    select[NSForegroundColorAttributeName] = [UIColor lc_baseColor];

    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normal forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:select forState:(UIControlStateSelected)];

    [UITabBar appearance].barTintColor = [UIColor whiteColor];
}

@end
