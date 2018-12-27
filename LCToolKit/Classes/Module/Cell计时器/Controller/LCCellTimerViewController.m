//
//  LCCellTimerViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/10.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCCellTimerViewController.h"
#import "LCTimerViewController.h"
#include <objc/runtime.h>


@interface LCCellTimerViewController ()

@end

@implementation LCCellTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)showCellOnClick:(UIButton *)sender {

    NSInteger tag = sender.tag - 100;

    LCTimerViewController *timerVC = [[LCTimerViewController alloc] init];
    timerVC.listTag = tag;
    timerVC.title = [NSString stringWithFormat:@"第%ld种方式", tag+1];
    [self.navigationController pushViewController:timerVC animated:YES];
}


@end
