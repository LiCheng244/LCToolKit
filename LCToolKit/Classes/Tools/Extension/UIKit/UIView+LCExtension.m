//
//  UIView+Extension.m
//  LCExtensions
//
//  Created by LiCheng on 2017/2/25.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "UIView+LCExtension.h"

@implementation UIView (LCExtension)

@end


#pragma mark - ------------- 位置相关 ---------------
@implementation UIView (Frame)

#pragma mark  ---- 位置 ----
- (void)setLc_x:(CGFloat)lc_x {

    CGRect frame   = self.frame;
    frame.origin.x = lc_x;
    self.frame     = frame;
}

- (CGFloat)lc_x {
    return self.frame.origin.x;
}


- (void)setLc_y:(CGFloat)lc_y {

    CGRect frame   = self.frame;
    frame.origin.y = lc_y;
    self.frame     = frame;
}

- (CGFloat)lc_y {
    return self.frame.origin.y;
}


- (void)setLc_origin:(CGPoint)lc_origin {

    CGRect frame = self.frame;
    frame.origin = lc_origin;
    self.frame   = frame;
}

- (CGPoint)lc_origin {
    return self.frame.origin;
}


#pragma mark ---- 大小 ----
- (void)setLc_width:(CGFloat)lc_width{

    CGRect frame     = self.frame;
    frame.size.width = lc_width;
    self.frame       = frame;
}

- (CGFloat)lc_width {
    return self.frame.size.width;
}


- (void)setLc_height:(CGFloat)lc_height {

    CGRect frame      = self.frame;
    frame.size.height = lc_height;
    self.frame        = frame;
}

- (CGFloat)lc_height{
    return self.frame.size.height;
}


- (void)setLc_size:(CGSize)lc_size {

    CGRect frame = self.frame;
    frame.size   = lc_size;
    self.frame   = frame;
}

- (CGSize)lc_size {
    return self.frame.size;
}


#pragma mark ---- 中心点 ----
- (void)setLc_centerX:(CGFloat)lc_centerX {

    CGPoint center = self.center;
    center.x       = lc_centerX;
    self.center    = center;
}

- (CGFloat)lc_centerX {
    return self.center.x;
}


-(void)setLc_centerY:(CGFloat)lc_centerY {

    CGPoint center = self.center;
    center.y       = lc_centerY;
    self.center    = center;
}

-(CGFloat)lc_centerY{
    return self.center.y;
}

@end


#pragma mark - ------------- 控制器相关 -------------
@implementation UIView (ViewController)

/**
 获取当前 view 所在的 controller

 @return 视图所在控制器
 */
- (UIViewController *)lc_currentViewOfController {

    for (UIView *view = [self superview]; view ; view = view.superview) {

        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end


#pragma mark - ------------- xib相关 -------------
@implementation UIView (Xib)

/**
 在 xib 中设置 圆角相关属性
 */

- (void)setCornerRadius:(NSInteger)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (NSInteger)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(NSInteger)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (NSInteger)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setMasksToBounds:(BOOL)bounds {
    self.layer.masksToBounds = bounds;
}

- (BOOL)masksToBounds {
    return self.layer.masksToBounds;
}


/// 快速加载 view 对应的 xib
+ (instancetype)lc_viewFromNib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

@end

#pragma mark - ------------- 控制器相关 -------------
#pragma mark - ------------- 控制器相关 -------------
#pragma mark - ------------- 控制器相关 -------------
#pragma mark - ------------- 控制器相关 -------------
#pragma mark - ------------- 控制器相关 -------------

