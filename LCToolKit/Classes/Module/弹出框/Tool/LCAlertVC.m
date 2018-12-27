//
//  LCAlertVC.m
//  LCToolKit
//
//  Created by LiCheng on 2018/2/1.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCAlertVC.h"
#import "FKCenterAnimation.h"

@interface LCAlertVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (nonatomic, copy  ) NSString *alertTitle;

@end

@implementation LCAlertVC

+ (instancetype)fk_showAlertVCWithDelegate:(id)delegate {

    LCAlertVC *alert = [[LCAlertVC alloc] init];
    alert.alertTitle = @"你好";
    alert.transitioningDelegate = alert;
    alert.delegate = delegate;
    alert.modalPresentationStyle = UIModalPresentationCustom;

    return alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleL.text = self.alertTitle;
}


- (IBAction)closeClick:(id)sender {

    if ([self.delegate respondsToSelector:@selector(closeAdvertClick)]) {
        [self.delegate closeAdvertClick];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


/// 返回一个管理prenent动画过渡的对象
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    return [[FKCenterAnimation alloc] init];
}

/// 初始化dismissType
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {

    return [[FKCenterAnimation alloc] init];
}

@end
