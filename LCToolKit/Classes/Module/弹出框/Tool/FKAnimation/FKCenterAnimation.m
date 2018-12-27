//
//  FKCenterAnimation.m
//  LCToolKit
//
//  Created by LiCheng on 2018/2/1.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "FKCenterAnimation.h"
#import "LCAlertVC.h"

#define TO_KEY   UITransitionContextToViewControllerKey
#define FROM_KEY UITransitionContextFromViewControllerKey


@implementation FKCenterAnimation


/// 动画持续时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *toVC   = [transitionContext viewControllerForKey:TO_KEY];   // 即将显示的视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:FROM_KEY]; // 即将消失的视图

    if (toVC.isBeingPresented) { // 显示视图 弹出时间
        return 0.3;
    } else if (fromVC.isBeingDismissed) { // 消失视图 隐藏时间
        return 0.1;
    }

    return 0.3;
}

/// 要执行的动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIViewController *toVC   = [transitionContext viewControllerForKey:TO_KEY];     // 即将显示的视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:FROM_KEY];   // 即将消失的视图
    if (!toVC || !fromVC) {
        return;
    }

    UIView *bgView          = toVC.view.subviews[0];                       // 半透明背景视图
    UIView *contentView     = toVC.view.subviews[1];                       // 样式视图
    UIView *containerView   = [transitionContext containerView];           // 容器视图
    NSTimeInterval duration = [self transitionDuration:transitionContext]; // 持续时间

    if (toVC.isBeingPresented) { /// 显示视图 - 显示

        [containerView addSubview:toVC.view];
    
        CGAffineTransform oldTransform = contentView.transform;
        toVC.view.frame       = CGRectMake(0.0, 0.0, containerView.frame.size.width, containerView.frame.size.height);
        contentView.transform = CGAffineTransformScale(oldTransform, 0.3, 0.3);
        contentView.center    = containerView.center;
        bgView.alpha          = 0.0;

        // 动画
        [UIView animateWithDuration:duration animations:^{
            bgView.alpha = 0.7;
            contentView.transform = oldTransform;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];

    } else if (fromVC.isBeingDismissed) { /// 消失视图 - 消失

        [UIView animateWithDuration:duration animations:^{
            fromVC.view.alpha = 0.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

@end
