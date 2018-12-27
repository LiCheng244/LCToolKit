//
//  LCLayerRoundViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/4/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCLayerRoundViewController.h"

@interface LCLayerRoundViewController ()

@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *xibView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation LCLayerRoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.type == 1) { /// xib

        self.title = @"xib 创建";
        self.codeView.hidden = YES;
        self.xibView.hidden  = NO;

        /*
         #import <UIKit/UIKit.h>

         IB_DESIGNABLE  // 设置动态刷新

         @interface UIView (LCExtension)

         @property (nonatomic, assign)IBInspectable CGFloat borderWidth;

         // IBInspectable 在 xib 中显示该属性

         @end
         */


    } else { /// 纯代码

        self.title = @"纯代码创建";
        self.codeView.hidden = NO;
        self.xibView.hidden  = YES;

        self.bgView.layer.masksToBounds = YES;                        // 允许剪裁
        self.bgView.layer.cornerRadius  = 10.0f;                      // 圆角大小
        self.bgView.layer.borderColor   = [UIColor redColor].CGColor; // 边框颜色
        self.bgView.layer.borderWidth   = 4.0f;                       // 边框宽度

        self.imgView.layer.masksToBounds = YES;
        self.imgView.layer.cornerRadius  = 5.0f;
        self.imgView.layer.borderColor   = [UIColor yellowColor].CGColor;
        self.imgView.layer.borderWidth   = 2.0f;
    }
}


@end
