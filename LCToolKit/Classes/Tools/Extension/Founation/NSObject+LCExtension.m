//
//  NSObject+LCExtension.m
//  LSLoginSDK
//
//  Created by LiCheng on 2017/7/18.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "NSObject+LCExtension.h"

@implementation NSObject (LCExtension)
@end



@implementation NSObject (ViewController)


/// 获取当前根视图控制器
+ (instancetype)lc_currentRootController {

    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;

    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
