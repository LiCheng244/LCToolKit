//
//  LCDYLodingViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/28.
//  Copyright © 2018 LiCheng. All rights reserved.
//

// @abstract 抖音加载动画
// @discussion 抖音加载动画

#import "LCDYLodingViewController.h"
#import "LCDYLodingView.h"

@interface LCDYLodingViewController ()

@end

@implementation LCDYLodingViewController

- (IBAction)onClick:(id)sender {
    
    NSLog(@"conClick");
}

- (IBAction)onClick1:(id)sender {
    
    NSLog(@"conClick1");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LCDYLodingView showLodingInView:self.view];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [LCDYLodingView hideLodingInView:self.view];
}
@end
