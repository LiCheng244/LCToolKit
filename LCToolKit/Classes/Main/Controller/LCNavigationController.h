//
//  LCNavigationController.h
//  LCToolKit
//
//  Created by LiCheng on 2017/12/8.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCNavigationController : UINavigationController


/**
 设置子控制器
 */
+ (LCNavigationController *)setupChildVC:(UIViewController *)vc
                                   title:(NSString *)title
                                   image:(NSString *)image
                             selectImage:(NSString *)selectImage;
@end
