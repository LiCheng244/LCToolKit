//
//  LCRoundViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/4/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCRoundViewController.h"
#import "LCLayerRoundViewController.h"

@interface LCRoundViewController ()

@end

@implementation LCRoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/// 纯代码创建圆角
- (IBAction)codeRoundViewClick:(id)sender {

    LCLayerRoundViewController *roundVC = [[LCLayerRoundViewController alloc] init];
    roundVC.type = 2;
    [self.navigationController pushViewController:roundVC animated:YES];
}


/// xib创建圆角
- (IBAction)xibRoundViewClick:(id)sender {

    LCLayerRoundViewController *roundVC = [[LCLayerRoundViewController alloc] init];
    roundVC.type = 1;
    [self.navigationController pushViewController:roundVC animated:YES];
}

@end
