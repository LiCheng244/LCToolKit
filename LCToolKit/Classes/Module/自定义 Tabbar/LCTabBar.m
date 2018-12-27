//
//  XXTabBar.m
//  Tabbar
//
//  Created by LiCheng on 2018/4/3.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCTabBar.h"
#import "LCTabBarController.h"

@interface LCTabBar ()

/// 中间凸起的按钮
@property (nonatomic, strong) UIButton *centerBtn;


@end

@implementation LCTabBar

#pragma mark - ------ Lazy Load ------
- (UIButton *)centerBtn {

    if (_centerBtn == nil) {

        _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, -11, 90, 60)];
        _centerBtn.backgroundColor = [UIColor clearColor];
        [_centerBtn setImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [_centerBtn addTarget:self action:@selector(clickCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}

- (void)clickCenterBtn:(UIButton *)btn {

    LCTabBarController *vc = (LCTabBarController *)[UIViewController lc_currentRootController];

    UIViewController *vv = [[UIViewController alloc] init];
    vv.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vv];
    [vc.selectedViewController presentViewController:nav animated:YES completion:nil];
}

#pragma mark - ------ System Method ------
/// 初始化
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.centerBtn];
    }

    return self;
}


/// 处理点击
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    UIView *result = [super hitTest:point withEvent:event];

    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }

    // 如果事件发生在 tabbar 里面直接返回
    if (result) {
        return result;
    }

    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.subviews) {

        // 把这个坐标从tabbar的坐标系转为 subview 的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在 subView 里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}

/// 重新布局
- (void)layoutSubviews {
    [super layoutSubviews];

    // 把 tabBarButton 取出来（把 tabBar 的 subViews 打印出来就明白了）
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }

//    // 图片下移
//    CGFloat offset = 5.0;
//    for (UITabBarItem *item in self.items) {
//        item.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
//    }

    CGFloat barWidth = self.bounds.size.width;
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);

    // 设置中间按钮的位置，居中，凸起一丢丢
    self.centerBtn.lc_centerX = barWidth / 2;

    // 重新布局其他 tabBarItem
    // 平均分配其他 tabBarItem 的宽度
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
    // 逐个布局 tabBarItem，修改 UITabBarButton 的 frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {

        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count / 2) {
            // 重新设置 x 坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        // 重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    // 把中间按钮带到视图最前面
    [self bringSubviewToFront:self.centerBtn];
}

@end
