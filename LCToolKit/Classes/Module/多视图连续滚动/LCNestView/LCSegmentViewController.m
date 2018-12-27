//
//  LCSegmentViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCSegmentViewController.h"
#import "LCNestView.h"

@interface LCSegmentViewController () <UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) NSNumber *selectedPageIndex;

@end

@implementation LCSegmentViewController

#pragma mark - ------ Setter Getter Methods ------


#pragma mark - ------ Lazyout Methods ------


#pragma mark - ------ System Methods ------

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //子控制器视图到达顶部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"goTop" object:nil];
    //子控制器视图离开顶部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    //切换分页选项的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:CurrentSelectedChildViewControllerIndex object:nil];
    //返回顶部的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:SegementViewChildVCBackToTop object:nil];
}


#pragma mark - ------ UILayout Methods ------


#pragma mark - ------ Network Methods ------


#pragma mark - ------ Private Methods ------

- (void)acceptMsg:(NSNotification *)notification {
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:@"goTop"]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
            self.scrollView.showsVerticalScrollIndicator = YES;
        } else {
            self.canScroll = NO;
        }
    } else if ([notificationName isEqualToString:@"leaveTop"]){
        self.canScroll = NO;
        self.scrollView.contentOffset = CGPointZero;
        self.scrollView.showsVerticalScrollIndicator = NO;
    } else if ([notificationName isEqualToString:CurrentSelectedChildViewControllerIndex]) {
        NSDictionary *userInfo = notification.userInfo;
        self.selectedPageIndex = userInfo[@"selectedPageIndex"];
    } else if ([notificationName isEqualToString:SegementViewChildVCBackToTop]) {
        [self.scrollView setContentOffset:CGPointZero];
    }
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil userInfo:@{@"canScroll":@"1"}];
    }
    self.scrollView = scrollView;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([self.selectedPageIndex isEqualToNumber:@0]) {
        return YES;
    }
    return NO;
}



@end
