//
//  LCLinkageViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/7.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCLinkageViewController.h"
#import "LCOneViewController.h"
#import "SDCycleScrollView.h"
#import "JQHeaderView.h"

#define FONTMAX 15.0
#define FONTMIN 14.0
#define PADDING 15.0

#define TAGS  @[@"推荐",@"原创",@"热门",@"美食",@"生活",@"设计感",@"家居",@"礼物"]

@interface LCLinkageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *currentSelectedItemImageView;

@property (nonatomic, strong) UIScrollView *mainScrollV;
@property (nonatomic, strong) SDCycleScrollView *advertView; // 顶部广告
@property (nonatomic, strong) UIScrollView *menuView;
@property (nonatomic, strong) UITableView *currentTV; // 当前 taleview

@property (nonatomic, strong) NSMutableArray *subVCs;  // controller
@property (nonatomic, strong) NSMutableArray *subTVs;  // tableView
@property (nonatomic, assign) CGFloat lastTVOffsetY;
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) UIButton *previousBtn;

@property (nonatomic, strong) JQHeaderView *headerView;
@end

@implementation LCLinkageViewController

#pragma mark - ------ Layout ------
-(NSMutableArray *)subVCs {
    
    if(!_subVCs) {
        _subVCs = [NSMutableArray array];
    }
    return _subVCs;
}

-(NSMutableArray *)subTVs {
    
    if(!_subTVs) {
        _subTVs = [NSMutableArray array];
    }
    return _subTVs;
}

-(SDCycleScrollView *)advertView {
    
    if(!_advertView) {
        
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 1; i<9; i++) {
            NSString *imageName = [NSString stringWithFormat:@"cycle_%02d.jpg",i];
            [images addObject:imageName];
        }
        
        _advertView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) imageNamesGroup:images];
    }
    return _advertView;
}

- (JQHeaderView *)jqHeaderView {
    
    if (!_headerView) {
        
        _headerView = [[JQHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _headerView.backgroundColor = [UIColor clearColor];
        
    }
    return _headerView;
}

-(UIScrollView *)mainScrollV {
    
    if(!_mainScrollV) {
        _mainScrollV = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))];
        _mainScrollV.delegate = self;
        _mainScrollV.pagingEnabled = YES;
        
        // 初始化子控制器
        for (int i = 0; i < TAGS.count; i++) {
            
            LCOneViewController *subVC = [[LCOneViewController alloc] init];
            subVC.tableView.backgroundColor = [UIColor lc_randomColor];
            subVC.view.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [_mainScrollV addSubview:subVC.view];
            
            [self.subTVs addObject:subVC.tableView];
            [self.subVCs addObject:subVC];
            
            // 添加监听
            NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
            [subVC.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
        }
        
        self.currentTV = self.subTVs[0];
        _mainScrollV.contentSize = CGSizeMake(self.subTVs.count*SCREEN_WIDTH, 0);
    }
    return _mainScrollV;
}

#pragma mark - ------ Layout ------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainScrollV];
    [self.view addSubview:self.advertView];
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    UITableView *tableView = (UITableView *)object;
    
    if (!(self.currentTV == tableView)) {
        return;
    }
    
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    CGFloat tvOffsetY = tableView.contentOffset.y;
    
    self.lastTVOffsetY = tvOffsetY;
    
    if (tvOffsetY >= 0 && tvOffsetY <= 136) {
        
        self.menuView.frame = CGRectMake(0, 200-tvOffsetY, SCREEN_WIDTH, 40);
        self.advertView.frame = CGRectMake(0, 0-tvOffsetY, SCREEN_WIDTH, 200);
        
    }else if( tvOffsetY < 0){
        
        self.menuView.frame = CGRectMake(0, 200, SCREEN_WIDTH, 40);
        self.advertView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        
    }else if (tvOffsetY > 136){
        
        self.menuView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
        self.advertView.frame = CGRectMake(0, -136, SCREEN_WIDTH, 200);
    }
    
    
}



#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView != self.mainScrollV) {
        return ;
    }
    
    int index =  scrollView.contentOffset.x/scrollView.frame.size.width;
    
    UIButton *currentBtn = self.btns[index];
    //     for (UIButton *button in self.titleButtons) {
    //         button.selected = NO;
    //     }
    _previousBtn.selected = NO;
    currentBtn.selected = YES;
    _previousBtn = currentBtn;
    
    self.currentTV  = self.subTVs[index];
    for (UITableView *tableView in self.subTVs) {
        
        if (self.lastTVOffsetY >= 0 && self.lastTVOffsetY <= 136) {
            tableView.contentOffset = CGPointMake(0, self.lastTVOffsetY);
            
        } else if (self.lastTVOffsetY < 0) {
            tableView.contentOffset = CGPointMake(0, 0);
            
        } else if (self.lastTVOffsetY > 136){
            tableView.contentOffset = CGPointMake(0, 136);
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (index == 0) {
            
            self.currentSelectedItemImageView.frame = CGRectMake(PADDING, self.menuView.frame.size.height - 2,currentBtn.frame.size.width, 2);
            
        }else{
            
            
            UIButton *preButton = self.btns[index - 1];
            
            float offsetX = CGRectGetMinX(preButton.frame)-PADDING*2;
            
            [self.menuView scrollRectToVisible:CGRectMake(offsetX, 0, self.menuView.frame.size.width, self.menuView.frame.size.height) animated:YES];
            
            self.currentSelectedItemImageView.frame = CGRectMake(CGRectGetMinX(currentBtn.frame), self.menuView.frame.size.height-2, currentBtn.frame.size.width, 2);
        }
        self.mainScrollV.contentOffset = CGPointMake(SCREEN_WIDTH *index, 0);
    }];
}

@end
