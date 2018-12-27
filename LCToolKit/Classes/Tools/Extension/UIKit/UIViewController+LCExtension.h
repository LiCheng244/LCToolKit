//
//  UIViewController+Extension.h
//  LSLoginSDK
//
//  Created by LiCheng on 2017/6/26.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LCExtension)


/**
 获取当前根视图控制器
 */
+ (instancetype)lc_currentRootController;



/**
 切换控制器

 @param viewVC  控制器
 */
- (void)lc_presentViewController:(UIViewController *)viewVC;


/**
 弹出一个半透明的控制器

 @param viewVC  控制器
 @param alpha   透明度 0-1
 */
- (void)lc_presentViewController:(UIViewController *)viewVC alpha:(CGFloat)alpha;

@end
