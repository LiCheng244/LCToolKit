//
//  LCTouchViewController.m
//  LCToolKit
//
//  Created by LiCheng on 2018/4/12.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCTouchViewController.h"

/// 指纹解锁框架
#import <LocalAuthentication/LocalAuthentication.h>

@interface LCTouchViewController ()

@property (weak, nonatomic) IBOutlet UIView *successV;
@property (weak, nonatomic) IBOutlet UIView *touchV;

@end

@implementation LCTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.successV.hidden = YES;
    self.touchV.hidden = NO;
}

/// 解锁
- (IBAction)touchClick:(id)sender {

    // 只支持 iOS 8 以上
    if (!IS_IOS_8Later) {
        NSLog(@"不支持指纹解锁");
        return;
    }

    // 创建 LAContext
    LAContext *context = [[LAContext alloc] init];

    // 兼容性处理
    if (@available(iOS 9.0, *)) {

        // 使用 TouchID 或密码验证   iOS 9.0 才有的方法
        [self laContext:context touchUnlockWith:(LAPolicyDeviceOwnerAuthentication)];

    } else {

        // 使用手指指纹去验证
        [self laContext:context touchUnlockWith:(LAPolicyDeviceOwnerAuthenticationWithBiometrics)];
    }
}


/// 指纹解锁
- (void)laContext:(LAContext *)context touchUnlockWith:(LAPolicy)policy {

    NSError *error = nil;
    NSString *result = @"请验证已有指纹";

    // 0. 判断设备是否支持
    if ([context canEvaluatePolicy:policy error:&error]) { // 支持

        // 1. 指纹验证
        [context evaluatePolicy:policy localizedReason:result reply:^(BOOL success, NSError * _Nullable error) {

            if (success) { // 验证成功

                NSLog(@"验证成功");
                dispatch_async(dispatch_get_main_queue(), ^{

                    self.successV.hidden = NO;
                    self.touchV.hidden = YES;
                });

            } else { // 验证失败

                switch (error.code) {
                    case LAErrorSystemCancel:
                        NSLog(@"系统取消收取，如其他 app 切入");
                        break;

                    case LAErrorUserCancel:
                        NSLog(@"用户取消验证");
                        break;

                    case LAErrorAuthenticationFailed:
                        NSLog(@"授权失败");
                        break;

                    case LAErrorPasscodeNotSet:
                        NSLog(@"系统未设置密码");
                        break;

                    case LAErrorTouchIDNotAvailable:
                        NSLog(@"设备Touch ID不可用，例如未打开")
                        break;

                    case LAErrorTouchIDNotEnrolled:
                        NSLog(@"设备Touch ID不可用，用户未录入")
                        break;

                    case LAErrorUserFallback:
                        NSLog(@"用户选择输入密码, 切换主线程处理");
                        break;

                    default:
                        NSLog(@"其他情况，切换主线程处理");
                        break;
                }
                NSLog(@"错误信息 - %@", error.localizedDescription);
            }
        }];

    } else { // 不支持

        NSLog(@"不支持指纹识别");

        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
                NSLog(@"指纹没有注册");
                break;

            case LAErrorPasscodeNotSet:
                NSLog(@"密码没有设置");
                break;

            default:
                NSLog(@"TouchID 不可以");
                break;
        }

        NSLog(@"%@",error.localizedDescription);
    }

}
@end
