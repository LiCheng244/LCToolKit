//
//  NSLayoutConstraint+Constraint.h
//  LSLoginSDK
//
//  Created by LiCheng on 2017/4/14.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (LCExtension)


/**
 中心点 X 约束

 @param view1       子视图
 @param view2       父视图
 */
+ (NSLayoutConstraint *)lc_centerXWithItem:(UIView *)view1
                                    toItem:(UIView *)view2;

/**
 中心点 Y 约束

 @param view1       子视图
 @param view2       父视图
 */
+ (NSLayoutConstraint *)lc_centerYWithItem:(UIView *)view1
                                    toItem:(UIView *)view2;

/**
 宽度 约束

 @param view        子视图
 @param width       宽度
 */
+ (NSLayoutConstraint *)lc_widthWithItem:(UIView *)view
                                   width:(CGFloat)width;

/**
 高度约束

 @param view        子视图
 @param height      高度
 */
+ (NSLayoutConstraint *)lc_heightWithItem:(UIView *)view
                                   height:(CGFloat)height;



/**
 距离父视图 顶部 约束

 @param view1       约束视图
 @param view2       父视图
 @param distance    距离
 */
+ (NSLayoutConstraint *)lc_topWithItem:(UIView *)view1
                                toItem:(UIView *)view2
                              distance:(CGFloat)distance;


/**
 距离父视图 底部 约束

 @param view1       约束视图
 @param view2       父视图
 @param distance    距离
 */
+ (NSLayoutConstraint *)lc_bottomWithItem:(UIView *)view1
                                   toItem:(UIView *)view2
                                 distance:(CGFloat)distance;

/**
 距离父视图 左部 约束

 @param view1       约束视图
 @param view2       父视图
 @param distance    距离
 */
+ (NSLayoutConstraint *)lc_leftWithItem:(UIView *)view1
                                 toItem:(UIView *)view2
                               distance:(CGFloat)distance;


/**
 距离父视图 右部 约束

 @param view1       约束视图
 @param view2       父视图
 @param distance    距离
 */
+ (NSLayoutConstraint *)lc_rightWithItem:(UIView *)view1
                                  toItem:(UIView *)view2
                                distance:(CGFloat)distance;

@end
