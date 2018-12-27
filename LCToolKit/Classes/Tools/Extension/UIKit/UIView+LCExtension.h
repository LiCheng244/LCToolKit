//
//  UIView+Extension.h
//  LCExtensions
//
//  Created by LiCheng on 2017/2/25.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE  // 动态刷新


@interface UIView (LCExtension)
@end

#pragma mark - ------ 布局相关 ------
@interface UIView (Frame)

#pragma mark 视图位置
/** 视图 Y 值 */
@property (nonatomic, assign)CGFloat lc_x;
/** 视图 Y 值 */
@property (nonatomic, assign)CGFloat lc_y;
/** 视图 位置 */
@property (nonatomic, assign)CGPoint lc_origin;

#pragma mark 视图大小
/** 视图 宽度 */
@property (nonatomic, assign)CGFloat lc_width;
/** 视图 高度 */
@property (nonatomic, assign)CGFloat lc_height;
/** 视图 size */
@property (nonatomic, assign)CGSize  lc_size;

#pragma mark 中心点
/** 视图 中心点 X */
@property (nonatomic, assign)CGFloat lc_centerX;
/** 视图 中心点 Y */
@property (nonatomic, assign)CGFloat lc_centerY;

@end


#pragma mark - ------ 控制器相关 ------
@interface UIView (ViewController)

/**
 获取当前 view 所在的 controller

 @return 视图所在控制器
 */
- (UIViewController *)lc_currentViewOfController;

@end


#pragma mark - ------ xib相关 ------
@interface UIView (Xib)

/**
    在 xib 中设置 圆角相关属性
 */
@property (assign,nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign,nonatomic) IBInspectable BOOL      masksToBounds;
@property (assign,nonatomic) IBInspectable NSInteger borderWidth;
@property (strong,nonatomic) IBInspectable UIColor   *borderColor;


/**
 快速加载 view 对应的 xib
 */
+ (instancetype)lc_viewFromNib;

@end



