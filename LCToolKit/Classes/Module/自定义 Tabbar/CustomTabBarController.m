//
//  XXTabBarController.m
//  Tabbar
//
//  Created by LiCheng on 2018/4/3.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "CustomTabBarController.h"

#import "LCTabBar.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController


#pragma mark - ------ System Methods ------

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

//    self.navigationController.navigationBar.hidden = YES;
}

/// 第一次调用
+ (void)initialize{

    UITabBar *tabbar = [UITabBar appearance];
    // 背景
    tabbar.shadowImage = [UIImage imageNamed:@"tabbar_bottom_line"];  // 顶部阴影图片
    tabbar.backgroundImage = [[UIImage alloc] init];                  // 背景图片
    tabbar.backgroundColor = [UIColor lc_hexCodeColor:@"fefefe"];     // 背景颜色

    UINavigationBar *bar  = [UINavigationBar appearance];
    UIBarButtonItem *item = [UIBarButtonItem appearance];

    // 0. 背景颜色
    [bar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:(UIBarMetricsDefault)];
    [bar setShadowImage:[UIImage new]]; // 取消下面的线
    [bar setTranslucent:NO];            // 是否透明

    // 1. 标题文字
    NSDictionary *barDict = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                              NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    [bar setTitleTextAttributes:barDict];
    [bar setTintColor:[UIColor whiteColor]];

    // 2. 左右按钮文字
    NSDictionary *itemDict = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                               NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [item setTitleTextAttributes:itemDict forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // 利用KVO来使用自定义的tabBar
    [self setValue:[[LCTabBar alloc] init] forKey:@"tabBar"];

    [self addAllChildViewController];
}

#pragma mark - ------ Private Methods ------
/// 添加全部的 childViewcontroller
- (void)addAllChildViewController {

    UIViewController *homeVC = [[UIViewController alloc] init];
    homeVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:homeVC title:@"xx" imageNamed:@"home"];

    UIViewController *activityVC = [[UIViewController alloc] init];
    activityVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:activityVC title:@"yy" imageNamed:@"home"];
}

/// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed {

//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];

    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageNamed];

    [self addChildViewController:vc];
}

@end
