//
//  NSLayoutConstraint+Constraint.m
//  LSLoginSDK
//
//  Created by LiCheng on 2017/4/14.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "NSLayoutConstraint+LCExtension.h"

@implementation NSLayoutConstraint (LCExtension)


/// 中心点 X 约束
+ (NSLayoutConstraint *)lc_centerXWithItem:(UIView *)view1
                                    toItem:(UIView *)view2 {

    NSLayoutConstraint *x = [NSLayoutConstraint constraintWithItem:view1
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view2
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0];
    return x;
}


/// 中心点 Y 约束
+ (NSLayoutConstraint *)lc_centerYWithItem:(UIView *)view1
                                    toItem:(UIView *)view2 {

    NSLayoutConstraint *y = [NSLayoutConstraint constraintWithItem:view1
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view2
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0];
    return y;
}


/// 宽度 约束
+ (NSLayoutConstraint *)lc_widthWithItem:(UIView *)view
                                   width:(CGFloat)width {

    NSLayoutConstraint *w = [NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1
                                                          constant:width];
    return w;
}



/// 高度约束
+ (NSLayoutConstraint *)lc_heightWithItem:(UIView *)view
                                   height:(CGFloat)height {

    NSLayoutConstraint *h = [NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1
                                                          constant:height];
    return h;
}



/// 距离父视图 顶部 约束
+ (NSLayoutConstraint *)lc_topWithItem:(UIView *)view1
                                toItem:(UIView *)view2
                              distance:(CGFloat)distance {

    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view1
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:view2
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1
                                                            constant:distance];
    return top;
}



/// 距离父视图 底部 约束
+ (NSLayoutConstraint *)lc_bottomWithItem:(UIView *)view1
                                   toItem:(UIView *)view2
                                 distance:(CGFloat)distance {

    NSLayoutConstraint *b = [NSLayoutConstraint constraintWithItem:view1
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view2
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:distance];
    return b;
}



/// 距离父视图 左部 约束
+ (NSLayoutConstraint *)lc_leftWithItem:(UIView *)view1
                                 toItem:(UIView *)view2
                               distance:(CGFloat)distance {

    NSLayoutConstraint *l = [NSLayoutConstraint constraintWithItem:view1
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view2
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1
                                                          constant:distance];
    return l;
}


/// 距离父视图 右部 约束
+ (NSLayoutConstraint *)lc_rightWithItem:(UIView *)view1
                                  toItem:(UIView *)view2
                                distance:(CGFloat)distance {

    NSLayoutConstraint *r = [NSLayoutConstraint constraintWithItem:view1
                                                         attribute:NSLayoutAttributeRight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:view2
                                                         attribute:NSLayoutAttributeRight
                                                        multiplier:1
                                                          constant:distance];
    return r;
}

@end
