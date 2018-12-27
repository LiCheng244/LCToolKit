//
//  LCAlertViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/2/1.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCAlertViewController.h"

#import "LCAlertVC.h"

@interface LCAlertViewController ()<AdvertAlertVCDeleagte>

@end

@implementation LCAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - ------ 自定义 alertController ------
- (IBAction)showCustomAlertClick:(id)sender {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题" message:@"内容" preferredStyle:UIAlertControllerStyleAlert];

    /// title 样式
    // 使用富文本来改变alert的title字体大小和颜色
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"这里是标题"];
    [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(0, 2)];
    [title addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [alert setValue:title forKey:@"attributedTitle"];


    /// message 样式
    // 使用富文本来改变alert的message字体大小和颜色
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"这里是正文信息"];
    [message addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, 6)];
    [message addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [message addAttribute:NSForegroundColorAttributeName value:[UIColor brownColor] range:NSMakeRange(3, 3)];
    [alert setValue:message forKey:@"attributedMessage"];


    /// 按钮样式
    UIAlertAction *okAction     = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    UIImage *accessoryImage = [[UIImage imageNamed:@"touch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 按钮背景图片
    [cancelAction setValue:accessoryImage forKey:@"image"];
    // 按钮的title颜色
    [cancelAction setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
    // title的对齐方式
    [cancelAction setValue:[NSNumber numberWithInteger:NSTextAlignmentLeft] forKey:@"titleTextAlignment"];

    [alert addAction:okAction];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - ------ 自定义 alert 视图 ------
- (IBAction)showCustomAlertViewClick:(id)sender {

    LCAlertVC *alert = [LCAlertVC fk_showAlertVCWithDelegate:self];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark  AdvertAlertVCDeleagte
- (void)closeAdvertClick {
    NSLog(@"关闭广告");
}



@end
