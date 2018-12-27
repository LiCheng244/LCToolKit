//
//  FKHomeContainerCell.m
//  ZWW
//
//  Created by LiCheng on 2018/4/8.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "ContainerCell.h"
#import "LCListScrollViewController.h"

@interface ContainerCell ()<UIScrollViewDelegate>

@end

@implementation ContainerCell

#pragma mark - ------ System Methods ------
/// xib
- (void)awakeFromNib {
    [super awakeFromNib];

    [self.contentView addSubview:self.scrollView];
}

/// 纯代码
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}




#pragma mark - ------ UIScrollViewDelegate ------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 为了横向滑动的时候，外层的tableView不动
    if (!self.isSelectIndex) {
        if (scrollView == self.scrollView) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(containerCell:scrollViewDidScroll:)]) {
                [self.delegate containerCell:self scrollViewDidScroll:scrollView];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isSelectIndex = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(containerCell:scrollViewDidEndDecelerating:)]) {
            [self.delegate containerCell:self scrollViewDidEndDecelerating:scrollView];
        }
    }
}

#pragma mark - ------ Lazy Load ------
- (UIScrollView *)scrollView {

    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64 - 44))];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 4, _scrollView.frame.size.height);
    }
    return _scrollView;
}

- (void)configScrollView {

    for (int i =0; i< _childVCs.count; i++) {
        LCListScrollViewController *vc = _childVCs[i];
        vc.view.frame = CGRectMake(SCREEN_WIDTH * i , 0, SCREEN_WIDTH, (SCREEN_HEIGHT - 64 - 44));
        [self.scrollView addSubview:vc.view];
    }
}


#pragma mark - ------ Setter ------
- (void)setChildVCs:(NSArray *)childVCs {

    _childVCs = childVCs;
    [self configScrollView];
}

- (void)setObjectCanScroll:(BOOL)objectCanScroll {

    _objectCanScroll = objectCanScroll;

    for (LCListScrollViewController *vc in _childVCs) {
        vc.vcCanScroll = objectCanScroll;
    }
    
    if (!objectCanScroll) {
        for (LCListScrollViewController *vc in _childVCs) {
            [vc.collectionV setContentOffset:CGPointZero animated:NO];
        }
    }
}
@end
