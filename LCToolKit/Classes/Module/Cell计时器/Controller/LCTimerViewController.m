//
//  LCTimerViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/10.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

// @abstract Timer
// @discussion cell 中使用 定时器

#import "LCTimerViewController.h"
#import "LCTimerOneCell.h"
#import "LCTimerTwoCell.h"
#import "LCTimerThreeCell.h"
#import "LCTimerFourCell.h"
#import "LCTimerFiveCell.h"


@interface LCTimerViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LCTimerViewController

#pragma mark - ------ Setter Getter Methods ------


#pragma mark - ------ Lazyout Methods ------


#pragma mark - ------ System Methods ------

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear = %@", [NSRunLoop currentRunLoop].currentMode);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableViewLayout];
    
    NSLog(@"viewDidLoad = %@", [NSRunLoop currentRunLoop].currentMode);
}


#pragma mark - ------ UILayout Methods ------
- (void)setupTableViewLayout {
  
    [self.tableView lc_registerNibName:[LCTimerOneCell class]];
    [self.tableView lc_registerNibName:[LCTimerTwoCell class]];
    [self.tableView lc_registerNibName:[LCTimerThreeCell class]];
    [self.tableView lc_registerNibName:[LCTimerFourCell class]];
    [self.tableView lc_registerNibName:[LCTimerFiveCell class]];
}


#pragma mark - ------ Network Methods ------


#pragma mark - ------ Private Methods ------


#pragma mark - ------ UITableViewDelegate ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.listTag) {
            
        case 0: {
            LCTimerOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCTimerOneCell"];
            return cell;
        }   break;
            
        case 1: {
            LCTimerTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCTimerTwoCell"];
            return cell;
        }   break;
            
        case 2: {
            LCTimerThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCTimerThreeCell"];
            return cell;
        }   break;
            
        case 3: {
            LCTimerFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCTimerFourCell"];
            return cell;
        }   break;
            
        case 4: {
            LCTimerFiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCTimerFiveCell"];
            return cell;
        }   break;
            
        default: {
            LCTimerOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LCTimerOneCell"];
            return cell;
        }   break;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - ------ UIScrollViewDelegate ------

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"scrollViewDidScroll = %@", [NSRunLoop currentRunLoop].currentMode);
}

@end
