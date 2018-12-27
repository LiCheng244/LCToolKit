//
//  LCMainScrollViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/4/11.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCMainScrollViewController.h"

#import "LCListScrollViewController.h"
#import "ContainerCell.h"
#import "HeaderView.h"
#import "LCTableView.h"

@interface LCMainScrollViewController () <UITableViewDelegate, UITableViewDataSource, ContainerCellDelegate, HeaderViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet LCTableView *tableV;
@property (nonatomic, strong) ContainerCell *containerCell;
@property (nonatomic, strong) HeaderView    *headerV;

@property (nonatomic, strong) NSArray *headerTitles;     // 标题数组
@property (nonatomic, strong) NSArray *childVCs;         // 子控制器
@property (nonatomic, assign) BOOL    canScroll;         // 可以滚动

@end

@implementation LCMainScrollViewController

#pragma mark - ------ Lazy Load ------
- (NSArray *)headerTitles {

    if(!_headerTitles) {
        _headerTitles  = @[@{@"title":@"全部",@"url":@"list_nav_00"},
                           @{@"title":@"新人推荐",@"url":@"list_nav_01"},
                           @{@"title":@"必抓爆款",@"url":@"list_nav_02"},
                           @{@"title":@"特价",@"url":@"list_nav_03"}];
    }
    return _headerTitles;
}

- (NSArray *)childVCs {

    if(!_childVCs) {

        LCListScrollViewController *vc1 = [[LCListScrollViewController alloc] init];
        [self addChildViewController:vc1];

        LCListScrollViewController *vc2 = [[LCListScrollViewController alloc] init];
        [self addChildViewController:vc2];

        LCListScrollViewController *vc3 = [[LCListScrollViewController alloc] init];
        [self addChildViewController:vc3];

        LCListScrollViewController *vc4 = [[LCListScrollViewController alloc] init];
        [self addChildViewController:vc4];

        _childVCs = @[vc1, vc2, vc3, vc4];

    }
    return _childVCs;
}

#pragma mark - ------ System Methods ------
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupHeaderViewData];
}


#pragma mark - ------ UI Layout ------
/// 初始化滚动视图相关数据
- (void)setupHeaderViewData {

    self.canScroll = YES;

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableV registerNib:[UINib nibWithNibName:NSStringFromClass([ContainerCell class]) bundle:nil] forCellReuseIdentifier:@"ContainerCell"];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
}

- (void)changeScrollStatus {

    self.canScroll = YES;
    self.containerCell.objectCanScroll = NO;
}

#pragma mark - ------ UITableViewDelegate ------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.section == 0) {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
            cell.backgroundColor = [UIColor yellowColor];
        }
        return cell;

    } else {

        // 列表
        _containerCell = [tableView dequeueReusableCellWithIdentifier:@"ContainerCell"];
        _containerCell.delegate  = self;
        _containerCell.childVCs = self.childVCs;
        return _containerCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 1) {

        _headerV = [[HeaderView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 44))];
        _headerV.titles = self.headerTitles;
        _headerV.delegate = self;
        return _headerV;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return (section == 0) ? 0 : 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return (indexPath.section == 0) ? 180 : SCREEN_HEIGHT - 64 - 44;
}


#pragma mark - ------ UIScrollViewDelegate ------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == self.tableV) {

        CGFloat bottomCellOffset = [self.tableV rectForSection:1].origin.y ;
        bottomCellOffset = floorf(bottomCellOffset);

        if (scrollView.contentOffset.y >= bottomCellOffset) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            if (self.canScroll) {
                self.canScroll = NO;
                self.containerCell.objectCanScroll = YES;
            }
        } else {
            //子视图没到顶部
            if (!self.canScroll) {
                scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
            }
        }
    }
}

#pragma mark - ------ HomeListHeaderViewDelegate ------
#pragma mark   头部滚动导航图
-(void)headerViewWillBeginDraggin:(HeaderView *)view {
    self.tableV.scrollEnabled = NO;
}

-(void)headerViewDidEndDecelerating:(HeaderView *)view {
    self.tableV.scrollEnabled = YES;
}

-(void)headerView:(HeaderView *)view startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {

    [self.containerCell.scrollView setContentOffset:CGPointMake(endIndex*[UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    self.containerCell.isSelectIndex = YES;
    self.tableV.scrollEnabled = YES;
}

#pragma mark - ------ FKHomeContainerCellDelegate ------
#pragma mark   容器视图
-(void)containerCell:(ContainerCell *)cell scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger page = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    _headerV.selectIndex = page;

    self.containerCell.isSelectIndex = YES;
    self.tableV.scrollEnabled = YES;
}

-(void)containerCell:(ContainerCell *)cell scrollViewDidScroll:(UIScrollView *)scrollView {
    self.tableV.scrollEnabled = NO;
}



@end
