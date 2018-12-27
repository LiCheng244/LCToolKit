//
//  LCNestSegmentView.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCNestSegmentView.h"
#import "LCOneViewController.h"
#import "SegmentHeaderView.h"
#import "LCNestView.h"

@interface LCNestSegmentView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SegmentHeaderView *headerView;

@end

@implementation LCNestSegmentView

-(UIScrollView *)scrollView {
    
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SEGMENT_HEIGHT, self.lc_width, self.lc_height - SEGMENT_HEIGHT)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;

    }
    return _scrollView;
}

// 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
    }
    return self;
}


- (void)setChirldVCs:(NSArray *)chirldVCs {
  
    _chirldVCs = chirldVCs;
    
    for (int i=0; i<_chirldVCs.count; i++) {
        UIViewController *vc = _chirldVCs[i];
        vc.view.frame = CGRectMake(i*self.lc_width, 0, self.lc_width, self.lc_height);
        [_scrollView addSubview:vc.view];
        [_parentVC addChildViewController:vc];
        [vc didMoveToParentViewController:_parentVC];
    };
    _scrollView.contentSize = CGSizeMake(_chirldVCs.count *self.lc_width, 0);
}

- (void)setTitles:(NSArray *)titles {
    
    _titles = titles;
    if (self.headerView == nil) {
        
        self.headerView = [[SegmentHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.lc_width, SEGMENT_HEIGHT) titleArray:_titles];
        [self addSubview:self.headerView];
        [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(SegmentHeaderViewHeight);
        }];
        __weak  typeof(self) weakSelf = self;
        weakSelf.headerView.selectedItemHelper = ^(NSUInteger index) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.scrollView setContentOffset:CGPointMake(index * self.lc_width, 0) animated:NO];
            [[NSNotificationCenter defaultCenter] postNotificationName:CurrentSelectedChildViewControllerIndex object:nil userInfo:@{@"selectedPageIndex" : @(index)}];
        };
    }
}


#pragma mark - UIScrollViewDelegate
//增加分页视图左右滑动和外界tableView上下滑动互斥处理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:IsEnablePersonalCenterVCMainTableViewScroll object:nil userInfo:@{@"canScroll" : @"0"}];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [[NSNotificationCenter defaultCenter] postNotificationName:IsEnablePersonalCenterVCMainTableViewScroll object:nil userInfo:@{@"canScroll" : @"1"}];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger selectedIndex = (NSUInteger)(self.scrollView.contentOffset.x / self.lc_width);
    [self.headerView changeItemWithTargetIndex:selectedIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:CurrentSelectedChildViewControllerIndex object:nil userInfo:@{@"selectedPageIndex" : @(selectedIndex)}];
}


@end
