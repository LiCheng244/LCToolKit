//
//  LCDaryMenuViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/19.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCDaryMenuViewController.h"
#import "CustomCell.h"

@interface LCDaryMenuViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *secArr;
@property (nonatomic, assign) BOOL isExp;

@end

@implementation LCDaryMenuViewController

-(UICollectionView *)collectionV {
    
    if(!_collectionV) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setHeaderReferenceSize:CGSizeMake(self.view.lc_width, 55)];
        
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
        [_collectionV lc_registerNibName:[CustomCell class]];
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        _collectionV.backgroundColor = [UIColor whiteColor];
        _collectionV.dataSource = self;
        _collectionV.delegate = self;
        UILongPressGestureRecognizer *longGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(setupLongPressGR:)];
        [_collectionV addGestureRecognizer:longGR];
    }
    return _collectionV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArr = [NSMutableArray arrayWithArray:@[@"首页",@"排行",@"国内",@"国际",@"社会",@"评论",@"数读",@"军事",@"航空"]];
    self.secArr  = [NSMutableArray arrayWithArray:@[@"无人机",@"新闻学院",@"政务",@"公益",@"媒体",@"旅游",@"学习",@"美女"]];
    
    self.isExp = YES;
    [self.view addSubview:self.collectionV];
}


/// 设置长按手势
- (void)setupLongPressGR:(UILongPressGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:sender.view];
    
    // 获取点击的indexPath
    NSIndexPath *indexPath = [self.collectionV indexPathForItemAtPoint:point];
    
    // 只允许第一分区拖动
    if (indexPath.section != 0) {
        return;
    }
    
    // 监听手势
    switch (sender.state) {
            
        case UIGestureRecognizerStateBegan: {
            NSLog(@"开始");
            if (@available(iOS 9.0, *)) {
                [self.collectionV beginInteractiveMovementForItemAtIndexPath:indexPath];
            } else {
                // Fallback on earlier versions
            }
        } break;
            
        case UIGestureRecognizerStateChanged: {
            NSLog(@"手势状态改变时");
            if (@available(iOS 9.0, *)) {
                [self.collectionV updateInteractiveMovementTargetPosition:point];
            } else {
                // Fallback on earlier versions
            } // 刷新
        } break;
            
        case UIGestureRecognizerStateEnded: {
            NSLog(@"结束");
            if (@available(iOS 9.0, *)) {
                [self.collectionV endInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
        } break;
            
        default: {
            if (@available(iOS 9.0, *)) {
                [self.collectionV cancelInteractiveMovement];
            } else {
                // Fallback on earlier versions
            }
        }
            break;
    }
}


- (void)setupTapGR:(UITapGestureRecognizer *)sender {
    
    sender.view.tag = !sender.view.tag;
    
    sender.view.tag = sender.view.tag ? (self.isExp = YES) : (self.isExp = NO);
    
    [self.collectionV reloadData];
}

#pragma mark - ------ UICollectionViewDelegate ------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  
    if (section == 0) {
        return self.dataArr.count;
        
    } else {
        
        if (self.isExp) {
            return self.secArr.count;
        }else {
            return 0;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.title.text = self.dataArr[indexPath.row];
    }else {
        cell.title.text = self.secArr[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
    if (indexPath.section == 0) {
        NSString *titles = self.dataArr[indexPath.item];
        [self.secArr addObject:titles];
        [self.dataArr removeObjectAtIndex:indexPath.item];
    
    } else {
        NSString *titles = self.secArr[indexPath.item];
        [self.dataArr addObject:titles];
        [self.secArr removeObjectAtIndex:indexPath.row];
    }
    
    [self.collectionV reloadData];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.section == 0 ? YES : NO;
}

/// 设置格子大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(80, 35);
}

/// 间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

/// 设置区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *rView = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSString *title = indexPath.section == 0 ? @"切换栏目" : @"点击添加更多栏目";
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 45))];
        label.backgroundColor = [UIColor yellowColor];
        label.font = [UIFont systemFontOfSize:15];
        label.text = title;
        [view addSubview:label];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setupTapGR:)];
        [view addGestureRecognizer:tap];
        rView = view;
    }
    
    return rView;
    
}


/// 拖动排序
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    if (sourceIndexPath.section == 0 && destinationIndexPath.section == 0) {
        [self.dataArr exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    }
}




@end
