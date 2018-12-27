//
//  LCListScrollViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/4/11.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCListScrollViewController.h"
#import "FKHomeListCell.h"

@interface LCListScrollViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@end

@implementation LCListScrollViewController

#pragma mark - ------ System Methods ------
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionViewStyle];
}

#pragma mark - ------ UI Layout ------
/// collectionView
- (void)setupCollectionViewStyle {

    self.automaticallyAdjustsScrollViewInsets = NO;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection         = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing      = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset            = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.headerReferenceSize     = CGSizeMake(0, 0);

    CGFloat width = (SCREEN_WIDTH- 20)/2;
    layout.itemSize =CGSizeMake(width, width/500.0*427 + 52 + 14);

    self.collectionV.collectionViewLayout = layout;
    self.collectionV.showsVerticalScrollIndicator = NO;

    [self.collectionV registerNib:[UINib nibWithNibName:NSStringFromClass([FKHomeListCell class]) bundle:nil] forCellWithReuseIdentifier:@"FKHomeListCell"];
}

#pragma mark - ------ UICollectionViewDelegate ------

/// 分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/// 个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

/// 创建
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    FKHomeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FKHomeListCell" forIndexPath:indexPath];
    return cell;
}

/// 点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"点击");
}


#pragma mark - ------ UIScrollViewDelegate ------

/// 滚动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == self.collectionV) {

        if (!self.vcCanScroll) {
            scrollView.contentOffset = CGPointZero;
        }

        if (scrollView.contentOffset.y <= 0) {

            self.vcCanScroll = NO;
            scrollView.contentOffset = CGPointZero;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
        }
    }
}




@end
