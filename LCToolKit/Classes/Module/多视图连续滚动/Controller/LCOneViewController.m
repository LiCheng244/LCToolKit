//
//  LCOneViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/7.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCOneViewController.h"
#import "LCLinkageListCell.h"
#import "LCListModel.h"
#import "LCDetailViewController.h"

@interface LCOneViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation LCOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self loadListData];
}

-(void)setupTableView {
    
    [self.tableView lc_registerNibName:[LCLinkageListCell class]];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
}


#pragma mark - ------ UITableViewDelegate ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 280;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCLinkageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCLinkageListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCDetailViewController *vc = [[LCDetailViewController alloc] init];
    [[UIViewController lc_currentRootController].navigationController pushViewController:vc animated:YES];
}

#pragma mark - ------ Network ------

- (void)loadListData {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *dataArray = [[dic objectForKey:@"data"] objectForKey:@"topic"];
    
    self.models = [NSMutableArray array];
    for (int i = 0; i< dataArray.count; i++) {
        
        LCListModel *model = [[LCListModel alloc] init];
        NSDictionary *itemDic = dataArray[i];
        model.placeholderImage = [NSString stringWithFormat:@"recomand_%02d%@",i+1,@".jpg"];;
        model.picUrl = [itemDic objectForKey:@"pic"];
        model.title = [itemDic objectForKey:@"title"];
        model.views = [itemDic objectForKey:@"views"];
        model.likes = [itemDic objectForKey:@"likes"];
        
        NSDictionary *userDic = [itemDic objectForKey:@"user"];
        model.author = [userDic objectForKey:@"nickname"];
        
        [self.models addObject:model];
    }
    
    [self.tableView reloadData];
}


@end
