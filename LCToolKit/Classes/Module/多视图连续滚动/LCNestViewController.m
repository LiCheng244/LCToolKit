//
//  LCNestViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

// @discussion   UIScorllView  嵌套滚动


#import "LCNestViewController.h"

#import "LCNestView.h"

#import "LCNestTableView.h"
#import "LCNestNavigationView.h"
#import "LCNestSegmentView.h"
#import "LCNestCarouselView.h"
#import "LCNestNavigationView.h"

#import "LCNestOneViewController.h"
#import "LCNestTwoViewController.h"
#import "LCOneViewController.h"

@interface LCNestViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, LCCarouselViewDelegate>

@property (nonatomic, strong) LCNestTableView       *mainTableView; // 主视图
@property (nonatomic, strong) LCNestCarouselView    *carouselView;  // 头部滚动视图
@property (nonatomic, strong) LCNestSegmentView     *segmentView;   // 菜单栏
@property (nonatomic, strong) UIView     *navView;
@property (nonatomic, assign) BOOL isBacking;
@property (nonatomic, assign) BOOL canScroll;

@end

@implementation LCNestViewController

#pragma mark - ------ Setter Getter Methods ------


#pragma mark - ------ Lazyout Methods ------

- (LCNestTableView *)mainTableView {
    
    if(!_mainTableView) {
        
        _canScroll = YES;
        _mainTableView = [[LCNestTableView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)) style:(UITableViewStyleGrouped)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = self.segmentView;
        _mainTableView.tableHeaderView = self.carouselView;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.showsVerticalScrollIndicator = NO;
    }
    return _mainTableView;
}

- (LCNestCarouselView *)carouselView {
    
    if(!_carouselView) {
        _carouselView = [[LCNestCarouselView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 200))];
        _carouselView.delegate = self;
        _carouselView.datas = @[@"cycle_07.jpg", @"cycle_06.jpg", @"cycle_05.jpg"];
    }
    return _carouselView;
}

- (LCNestSegmentView *)segmentView {
    
    if(!_segmentView) {
        
        LCOneViewController *oneVC   = [[LCOneViewController alloc] init];
        LCOneViewController *twoVC   = [[LCOneViewController alloc] init];
        LCNestTwoViewController *threeVC = [[LCNestTwoViewController alloc] init];
        LCNestOneViewController *fourVC  = [[LCNestOneViewController alloc] init];
        LCNestTwoViewController *fiveVC  = [[LCNestTwoViewController alloc] init];
        LCNestOneViewController *sixVC   = [[LCNestOneViewController alloc] init];

        _segmentView = [[LCNestSegmentView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_BAR_HEIGHT-NAV_BAR_HEIGHT))];
        _segmentView.parentVC = self;
        _segmentView.chirldVCs = @[oneVC, twoVC, threeVC, fourVC, fiveVC, sixVC];
        _segmentView.titles = @[@"标题1", @"标题2", @"标题3", @"标题4", @"标题5", @"标题6"];
        _segmentView.selectedIndex = 1;
    }
    return _segmentView;
}

- (UIView *)navView {
    
    if (!_navView) {
        
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)];
        _navView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        //添加返回按钮
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:[UIImage imageNamed:@"next"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(5, 8 + STATUS_BAR_HEIGHT, 28, 25);
        backButton.adjustsImageWhenHighlighted = YES;
        [backButton addTarget:self action:@selector(backActionOnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_navView addSubview:backButton];
        
        //添加消息按钮
        UIButton *messageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [messageButton setImage:[UIImage imageNamed:@"home_sel_1"] forState:(UIControlStateNormal)];
        messageButton.frame = CGRectMake(SCREEN_WIDTH - 35, 8 + STATUS_BAR_HEIGHT, 25, 25);
        messageButton.adjustsImageWhenHighlighted = YES;
        [messageButton addTarget:self action:@selector(gotoMessagePageOnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_navView addSubview:messageButton];
    }
    return _navView;
}



#pragma mark - ------ System Methods ------

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.navigationBar.hidden = YES;
    self.navView.hidden = NO;
    
    if (self.carouselView) {
        [self.carouselView recoverCarousel];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.isBacking = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackingStatus" object:nil userInfo:@{@"isBacking":@(self.isBacking)}];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.carouselView stopCarousel];
    
    self.isBacking = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BackingStatus" object:nil userInfo:@{@"isBacking":@(self.isBacking)}];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController setNavigationBarHidden:NO];
    self.navView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.navView];
    
   
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //如果使用自定义的按钮去替换系统默认返回按钮，会出现滑动返回手势失效的情况
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //注册允许外层tableView滚动通知-解决和分页视图的上下滑动冲突问题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    //切换分页时禁止mainTableView上下滑动，停止分页左右滑动的时候允许mainTableView滑动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:IsEnablePersonalCenterVCMainTableViewScroll object:nil];
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - ------ UILayout Methods ------
- (void)backActionOnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gotoMessagePageOnClick {
    
}

#pragma mark - ------ Network Methods ------


#pragma mark - ------ Private Methods ------

/// 接收通知
- (void)acceptMsg:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    if ([notification.name isEqualToString:@"leaveTop"]) {
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
        }
    } else if ([notification.name isEqualToString:IsEnablePersonalCenterVCMainTableViewScroll]) {
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.mainTableView.scrollEnabled = YES;
        } else if ([canScroll isEqualToString:@"0"]) {
            self.mainTableView.scrollEnabled = NO;
        }
    }
}

#pragma mark - ------ UITableViewDelegate ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark - ------ UIScrollViewDelegate ------

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    
    //通知分页子控制器列表返回顶部
    [[NSNotificationCenter defaultCenter] postNotificationName:SegementViewChildVCBackToTop object:nil];
    
    return YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //当前偏移量
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    //吸顶临界点(此时的临界点不是感官上导航栏的底部，而是屏幕的顶部)
    CGFloat criticalPointOffsetY = scrollView.contentSize.height - SCREEN_HEIGHT;
    
    //更改导航栏的背景图的透明度
    CGFloat alpha = 0;
    if (currentOffsetY < 100 - STATUS_BAR_HEIGHT - NAV_BAR_HEIGHT) {
        alpha = currentOffsetY / (100 - STATUS_BAR_HEIGHT - NAV_BAR_HEIGHT);
    }else {
        alpha = 1;
    }
    
    self.navView.backgroundColor = [UIColor colorWithRed:255/255.0 green:126/255.0 blue:15/255.0 alpha:alpha];
    
    //利用contentOffset处理内外层scrollView的滑动冲突问题
    /* 主要规则：
     * ⚠️ 这里的”吸顶状态“和”到达临界点状态“不能完全划等号，这里一下子确实有点难以理解，我会在下方尽可能的简单   化表达出来
     * 一、吸顶状态: segmentView到达临界点(这里设置的临界点是导航栏底部，可以自定义))
     mainTableView不能滚动(固定mainTableView的位置-通过设置contentOffset的方式),segmentView的子控制器的tableView或collectionView在竖直方向上可以滚动；
     二、未吸顶状态:
     mainTableView能滚动,segmentView的子控制器的tableView或collectionView在竖直方向上不可以滚动；
     */
    if (currentOffsetY >= criticalPointOffsetY) {
        /*
         * 到达临界点 ：此状态下有两种情况
         * 1.未吸顶状态 -> 吸顶状态
         * 2.维持吸顶状态 (segmentView的子控制器的tableView或collectionView在竖直方向上的contentOffsetY大于0)
         */
        
        //下面这行代码是“维持吸顶状态”和“进入吸顶状态”的共同代码
        scrollView.contentOffset = CGPointMake(0, criticalPointOffsetY);
        //进入吸顶状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
        self.canScroll = NO;
    } else {
        /*
         * 未达到临界点 ：此状态下有两种情况，且这两种情况完全相反，这也是引入一个canScroll属性的重要原因
         * 1.吸顶状态 -> 不吸顶状态
         * 2.维持吸顶状态 (segmentView的子控制器的tableView或collectionView在竖直方向上的contentOffsetY大于0)
         */
        
        if (!self.canScroll) {
            //维持吸顶状态
            scrollView.contentOffset = CGPointMake(0, criticalPointOffsetY);
        } else {
            /* 吸顶状态 -> 不吸顶状态
             * segmentView的子控制器的tableView或collectionView在竖直方向上的contentOffsetY小于等于0时，会通过通知的方式改变self.canScroll的值；
             * 这里不再做多余处理，已经在SegmentViewController中做了处理-发送name为“leaveTop”的通知
             */
        }
    }
}

#pragma mark - ------ LCCarouselViewDelegate ------
- (void)lc_carouselView:(LCNestCarouselView *)view didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"didSelectItemAtIndex = %ld", index);
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
