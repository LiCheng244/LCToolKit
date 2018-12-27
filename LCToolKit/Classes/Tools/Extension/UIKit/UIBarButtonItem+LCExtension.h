//
//  UIBarButtonItem+LCExtension.h
//  LSSDK_DEV
//
//  Created by LiCheng on 2017/7/31.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LCExtension)


/**
 快速创建导航栏图片按钮

 @param image       按钮图片
 @param target      响应者
 @param action      点击事件
 */
+ (UIBarButtonItem *)lc_barButtonItemWithImageNamed:(NSString *)image
                                             target:(id)target
                                             action:(SEL)action;


@end
