//
//  UIViewController+Extension.m
//  LSLoginSDK
//
//  Created by LiCheng on 2017/6/26.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "UIViewController+LCExtension.h"

@implementation UIViewController (LCExtension)


/// 获取当前根视图控制器
+ (instancetype)lc_currentRootController {

//    UIViewController *result = nil;
//
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//
//    UIView *frontView = [[window subviews] objectAtIndex:0];
//    id nextResponder = [frontView nextResponder];
//
//    if ([nextResponder isKindOfClass:[UIViewController class]])
//        result = nextResponder;
//    else
//        result = window.rootViewController;
//
//    return result;

    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;

    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


/// 切换控制器
- (void)lc_presentViewController:(UIViewController *)viewVC {

    [self presentViewController:viewVC animated:YES completion:nil];
}


/// 弹出一个半透明的控制器
- (void)lc_presentViewController:(UIViewController *)viewVC alpha:(CGFloat)alpha {

    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    vc.definesPresentationContext = YES;

    viewVC.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
    viewVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    viewVC.view.autoresizesSubviews = YES;

    [vc presentViewController:viewVC animated:YES completion:nil];
}


@end
