//
//  LCDYLodingView.h
//  LCToolKit
//
//  Created by LiCheng on 2018/12/28.
//  Copyright © 2018 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCDYLodingView : UIView


/**
 显示 loding
 */
+ (void)showLodingInView:(UIView *)view;


/**
 隐藏 loding
 */
+ (void)hideLodingInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
