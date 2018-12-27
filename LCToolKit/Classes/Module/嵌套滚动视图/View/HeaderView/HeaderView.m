//
//  HomeListHeaderView.m
//  ZWW
//
//  Created by LiCheng on 2017/11/5.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "HeaderView.h"

#define MARGIN 45

@interface HeaderView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView   *scrollV;
@property (nonatomic, strong) NSMutableArray *itemBtnArr;

@property (nonatomic, strong) UIView *indicatorView;    // 底部视图
@property (nonatomic, strong) UIFont *titleFont;        // 标题字体大小
@property (nonatomic, strong) UIFont *titleSelectFont;  // 标题选中字体大小

@end

@implementation HeaderView

#pragma mark - ------ 系统方法 ------



-(instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        // 属性
        self.titleFont        = [UIFont systemFontOfSize:13];
        self.titleSelectFont  = [UIFont boldSystemFontOfSize:15];
        self.selectIndex      = 0;
        self.backgroundColor  = [UIColor darkGrayColor];
    }
    return self;
}

/// 重新布局frame
- (void)layoutSubviews {

    [super layoutSubviews];

    self.scrollV.frame = self.bounds;
    if (self.itemBtnArr.count == 0) {
        return;
    }
    CGFloat totalBtnWidth = 0.0;
    UIFont *titleFont = _titleFont;

    // 文字
    if (_titleFont != _titleSelectFont) {

        for (int idx = 0; idx < self.titles.count; idx++) {
            UIButton *btn = self.itemBtnArr[idx];
            titleFont = btn.isSelected?_titleSelectFont:_titleFont;
            CGFloat itemBtnWidth = [self getWidthWithString:self.titles[idx][@"title"] font:titleFont] + MARGIN;
            totalBtnWidth += itemBtnWidth;
        }
    } else {

        for (NSDictionary *dict in self.titles) {
            CGFloat itemBtnWidth = [self getWidthWithString:dict[@"title"] font:titleFont] + MARGIN;
            totalBtnWidth += itemBtnWidth;
        }
    }

    // 不能滑动
    if (totalBtnWidth <= self.lc_width) {

        CGFloat btnWidth  = self.lc_width / self.itemBtnArr.count;
        CGFloat btnHeight = self.lc_height;

        for (int i  = 0; i < self.itemBtnArr.count; i++) {
            UIButton *btn = self.itemBtnArr[i];
            btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, btnHeight);
        }
        self.scrollV.contentSize = CGSizeMake(self.lc_width, self.scrollV.lc_height);

    } else { //超出屏幕 可以滑动

        CGFloat currentX = 0;
        for (int idx = 0; idx < self.titles.count; idx++) {

            UIButton *btn = self.itemBtnArr[idx];
            titleFont = btn.isSelected ? _titleSelectFont : _titleFont;

            CGFloat btnWidth  = [self getWidthWithString:self.titles[idx][@"title"] font:titleFont] + MARGIN;
            CGFloat btnHeight = self.lc_height;
            btn.frame = CGRectMake(currentX, 0, btnWidth, btnHeight);
            currentX += btnWidth;
        }
        self.scrollV.contentSize = CGSizeMake(currentX, self.scrollV.lc_height);
    }
    [self moveIndicatorView:YES];
}

/// 移动滑块
- (void)moveIndicatorView:(BOOL)animated {

    UIFont *titleFont = _titleFont;
    UIButton *selectBtn = self.itemBtnArr[self.selectIndex];
    titleFont = selectBtn.isSelected ? _titleSelectFont : _titleFont;
    CGFloat width = [self getWidthWithString:self.titles[self.selectIndex][@"title"] font:titleFont];

    [UIView animateWithDuration:(animated?0.05:0) animations:^{

        self.indicatorView.center = CGPointMake(selectBtn.lc_centerX, self.scrollV.lc_height - 2);
        self.indicatorView.bounds = CGRectMake(0, 0, width, 2);
        selectBtn.titleLabel.font = _titleSelectFont;

    } completion:^(BOOL finished) {
        [self scrollSelectBtnCenter:animated];
    }];
}

- (void)scrollSelectBtnCenter:(BOOL)animated {

    UIButton *selectBtn = self.itemBtnArr[self.selectIndex];
    CGRect centerRect = CGRectMake(selectBtn.lc_centerX - self.scrollV.lc_width/2, 0, self.scrollV.lc_width, self.scrollV.lc_height);
    [self.scrollV scrollRectToVisible:centerRect animated:animated];
}


#pragma mark - ------ LazyLoad 懒加载 ------
/// 滚动视图
- (UIScrollView *)scrollV {

    if (!_scrollV) {

        _scrollV = [[UIScrollView alloc] init];
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.scrollsToTop = NO;
        _scrollV.delegate = self;
        [self addSubview:_scrollV];
    }
    return _scrollV;
}

/// 按钮数组
- (NSMutableArray<UIButton *>*)itemBtnArr {

    if (!_itemBtnArr) {
        _itemBtnArr = [[NSMutableArray alloc]init];
    }
    return _itemBtnArr;
}

/// 滑块
- (UIView *)indicatorView {

    if (!_indicatorView) {

        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor lc_hexCodeColor:@"ff595f"];
        [self.scrollV addSubview:_indicatorView];
    }
    return _indicatorView;
}


#pragma mark - ------ setter ------
/// 属性
- (void)setTitles:(NSArray *)titles {

    _titles = titles;

    [self.itemBtnArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtnArr = nil;

    for (NSDictionary *dict in titles) {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = self.itemBtnArr.count + 666;

        [btn setTitle:dict[@"title"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:dict[@"url"]] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor lc_hexCodeColor:@"888888"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lc_hexCodeColor:@"333333"] forState:UIControlStateSelected];

        btn.titleLabel.font = _titleFont;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);

        [self.scrollV addSubview:btn];

        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

        if (self.itemBtnArr.count == self.selectIndex) {
            btn.selected = YES;
            btn.titleLabel.font = _titleSelectFont;
        }
        [self.itemBtnArr addObject:btn];
    }

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/// 选中下标
- (void)setSelectIndex:(NSInteger)selectIndex {

    if (_selectIndex == selectIndex || _selectIndex < 0 || _selectIndex > self.itemBtnArr.count - 1) {
        return;
    }

    UIButton *lastBtn = [self.scrollV viewWithTag:_selectIndex + 666];
    lastBtn.selected = NO;
    lastBtn.titleLabel.font = _titleFont;
    _selectIndex = selectIndex;

    UIButton *currentBtn = [self.scrollV viewWithTag:_selectIndex + 666];
    currentBtn.selected = YES;
    currentBtn.titleLabel.font = _titleSelectFont;

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/// 文字大小
- (void)setTitleFont:(UIFont *)titleFont {

    _titleFont = titleFont;

    for (UIButton *btn in self.itemBtnArr) {
        btn.titleLabel.font = titleFont;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/// 选中文字大小
- (void)setTitleSelectFont:(UIFont *)titleSelectFont {

    if (_titleFont == titleSelectFont) {
        _titleSelectFont = _titleFont;
        return;
    }
    _titleSelectFont = titleSelectFont;
    for (UIButton *btn in self.itemBtnArr) {
        btn.titleLabel.font = btn.isSelected?titleSelectFont:_titleFont;
    }

    [self setNeedsLayout];
    [self layoutIfNeeded];
}


#pragma mark - ------ 点击事件 ------

- (void)btnClick:(UIButton *)btn {

    NSInteger index = btn.tag - 666;
    if (index == self.selectIndex) {
        return;
    }

    self.selectIndex = index;
    if ([self.delegate respondsToSelector:@selector(headerView:startIndex:endIndex:)]) {
        [self.delegate headerView:self startIndex:self.selectIndex endIndex:index];
    }
}


#pragma mark - ------ Private 方法 ------

/// 计算字符串长度
- (CGFloat)getWidthWithString:(NSString *)string font:(UIFont *)font {

    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 0)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil];
    return rect.size.width + 6 + 15;
}


#pragma mark - ------ UIScrollViewDelegate ------

/// 开始拖拽
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    if ([self.delegate respondsToSelector:@selector(headerViewWillBeginDraggin:)]) {
        [self.delegate headerViewWillBeginDraggin:self];
    }
}

/// 结束拖拽
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    if ([self.delegate respondsToSelector:@selector(headerViewDidEndDecelerating:)]) {
        [self.delegate headerViewDidEndDecelerating:self];
    }
}



@end
