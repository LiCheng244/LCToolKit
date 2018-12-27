//
//  LCNestCarouselView.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCNestCarouselView.h"

#import "LCCarouselViewCell.h"


static CGFloat ScrollInterval = 3.0f;


@interface LCNestCarouselView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectonView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *itemDatas;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger currentPage;
@end


@implementation LCNestCarouselView

#pragma mark - ------ Lazyout Methods ------

-(UIPageControl *)pageControl {
    
    if(!_pageControl) {
        
        CGFloat pageCH = 35;
        _pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(0, self.lc_height-pageCH, self.lc_width, pageCH))];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

-(UICollectionView *)collectonView {
    
    if(!_collectonView) {
        
        // 布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.lc_width, self.lc_height);
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 创建
        _collectonView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectonView.delegate = self;
        _collectonView.dataSource = self;
        _collectonView.pagingEnabled = YES;
        _collectonView.backgroundColor = [UIColor yellowColor];
        _collectonView.showsHorizontalScrollIndicator = NO;
        [_collectonView lc_registerNibName:[LCCarouselViewCell class]];
    }
    return _collectonView;
}


#pragma mark - ------ Public Methods ------

/// 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUILayout];
    }    
    return self;
}

/// 暂停轮播
- (void)stopCarousel {
    
    if (self.timer) {
        [self.timer setFireDate:[NSDate distantFuture]];
        NSLog(@"--- 暂停轮播 ---");
    }
}

/// 恢复轮播
- (void)recoverCarousel {
    
    if (self.timer) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:ScrollInterval]];
        NSLog(@"--- 恢复轮播 ---");
    }
}

/// 设置数据
- (void)setDatas:(NSArray *)datas {
    
    _itemDatas = [NSMutableArray arrayWithArray:datas];
    
    if (datas.count <= 1) { // 一条数据时不滚动
        self.collectonView.scrollEnabled = NO;
        
    } else { // 处理多条数据
        
        [_itemDatas addObject:datas.firstObject];
        [_itemDatas insertObject:datas.lastObject atIndex:0];
        
        if (_timer == nil) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:ScrollInterval
                                                      target:self
                                                    selector:@selector(setupAutoCarousel)
                                                    userInfo:nil
                                                     repeats:YES];
        }
    }
    
    [self.collectonView setContentOffset:(CGPointMake(_collectonView.lc_width, 0))];
    _pageControl.numberOfPages = datas.count;
}


#pragma mark - ------ UILayout Methods ------

- (void)setupUILayout {
    
    [self addSubview:self.collectonView];
    [self addSubview:self.pageControl];
}


#pragma mark - ------ Private Methods ------

/// 自动轮播
- (void)setupAutoCarousel {
    
    // 手指拖拽时禁止自动轮播
    if (self.collectonView.isDragging) {
        return;
    }
    
    CGFloat targetX = self.collectonView.contentOffset.x + self.collectonView.lc_width;
    [self.collectonView setContentOffset:CGPointMake(targetX, 0) animated:YES];
}

/// 滚动
- (void)setupCarousel {
    
    NSInteger page = self.collectonView.contentOffset.x / self.collectonView.lc_width;
    
    if (page == 0) { // 滚动到左边
        self.collectonView.contentOffset = CGPointMake(self.collectonView.lc_width*(self.itemDatas.count-2), 0);
        self.pageControl.currentPage = _itemDatas.count-2;
        
    } else if (page == self.itemDatas.count-1) { // 滚动到右边
        self.collectonView.contentOffset = CGPointMake(_collectonView.lc_width, 0);
        self.pageControl.currentPage = 0;
        
    } else { // 正常
        self.pageControl.currentPage = page - 1;
    }
    
    self.currentPage = self.pageControl.currentPage;
    NSLog(@"currentPage = %ld", self.currentPage);
}


#pragma mark - ------ UICollectionDelegate ------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    LCCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LCCarouselViewCell" forIndexPath:indexPath];
    cell.itemData = self.itemDatas[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger page = self.collectonView.contentOffset.x / self.collectonView.lc_width;
    if (page == 0) { // 滚动到左边
        page = _itemDatas.count-2;
    } else if (page == self.itemDatas.count-1) { // 滚动到右边
        page = 0;
    } else { // 正常
        page = page - 1;
    }
    
    if ([self.delegate respondsToSelector:@selector(lc_carouselView:didSelectItemAtIndex:)]) {
        [self.delegate lc_carouselView:self didSelectItemAtIndex:page];
    }
}


#pragma mark - ------ UIScrollViewDelegate ------

/// 手势拖拽结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    // 滚动
    [self setupCarousel];
    
    // 计时器3秒后执行
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:ScrollInterval]];
}

/// 自动轮播结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 滚动
    [self setupCarousel];
}


- (void)dealloc {
  
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end
