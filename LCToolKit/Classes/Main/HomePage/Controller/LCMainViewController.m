//
//  LCMainViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2017/12/11.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCMainViewController.h"
#import "LCHomeListCell.h"

@interface LCMainViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modules;
@end

@implementation LCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadModulesData];

    self.title = @"主界面";

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCHomeListCell class]) bundle:nil] forCellReuseIdentifier:@"LCHomeListCell"];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - ------ 代理 ------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LCHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCHomeListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.module = self.modules[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *dict = self.modules[indexPath.row];

    Class myClass = NSClassFromString(dict[@"class"]);
    UIViewController *viewVC = [[myClass alloc] init];
    viewVC.title = dict[@"title"];
    viewVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewVC animated:YES];
}


#pragma mark - ------ 数据加载 ------

- (NSMutableArray *)modules {

    if(!_modules) {
        _modules = [NSMutableArray array];
    }
    return _modules;
}

- (void)loadModulesData {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Module" ofType:@"plist"];
    self.modules = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    [self.tableView reloadData];
}
@end
