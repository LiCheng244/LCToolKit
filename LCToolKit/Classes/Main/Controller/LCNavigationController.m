//
//  LCNavigationController.m
//  LCToolKit
//
//  Created by LiCheng on 2017/12/8.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCNavigationController.h"
#import "LCLinkageViewController.h"

@interface LCNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation LCNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    } else {

        return YES;
    }
}



/// 当第一次使用该类时, 会调用该方法
+ (void)initialize{

    // 设置导航栏背景图片
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.translucent = NO; // 是否透明
    bar.barTintColor = [UIColor lc_baseColor];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];

    // 取消分割新
    [bar setShadowImage:[UIImage new]];
    bar.tintColor = [UIColor whiteColor];


    // 左右按钮样式
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                   NSFontAttributeName:[UIFont systemFontOfSize:15]}
                        forState:UIControlStateNormal];
}


/// 设置子控制器
+ (LCNavigationController *)setupChildVC:(UIViewController *)vc
                                   title:(NSString *)title
                                   image:(NSString *)image
                             selectImage:(NSString *)selectImage {


    vc.tabBarItem.title         = title;
    vc.tabBarItem.image         = [[UIImage imageNamed:image] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];

    //    vc.view.backgroundColor = [UIColor redColor];
    /**
     *  不要在这里设置背景色:
     *      因为:在这里设置的话, 程序启动后会将四个控制器一次性都创建完毕 (因为 调用了self.view)
     *
     *  要做到每次点击下面tabBar时, 再创建控制器
     */

    // 包装导航栏控制, 并设置将其设置为tabBarContrller的子控制器
    LCNavigationController *nav = [[LCNavigationController alloc] initWithRootViewController:vc];
    nav.title = title;
    return nav;
}


/**
 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (self.childViewControllers.count > 0) {

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStyleDone) target:self action:@selector(backClick)];
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
}

- (void)backClick {

    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}

#pragma mark - ------ UINavigationControllerDelegate ------

/// 处理哪些控制器导航栏需要隐藏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isMine = [viewController isKindOfClass:[LCLinkageViewController class]];
    if (isMine) {
        [self setNavigationBarHidden:YES animated:YES];
    } else {
        [self setNavigationBarHidden:NO animated:YES];
    }
}


@end
