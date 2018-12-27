//
//  LCLaunchMovieVC.m
//  LCToolKit
//
//  Created by LiCheng on 2017/12/8.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCLaunchMovieVC.h"
#import "AppDelegate.h"
#import "LCTabBarController.h"

@interface LCLaunchMovieVC ()

@property (nonatomic, strong) UIImageView *bgImgView;

@end


@implementation LCLaunchMovieVC

-(BOOL)shouldAutorotate {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //隐藏状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBgImageView];
    [self setupNotificationCenter];
    [self setupPlayer];
}

#pragma mark - ------ UI 设置 ------
/// 背景图片 避免出现闪屏
-(void)setupBgImageView {

    self.bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgImgView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.bgImgView];
}

/// 设置监听事件
- (void)setupNotificationCenter {

    // 播放开始
    [NSNotificationCenter lc_addObserver:self
                                selector:@selector(lc_moviePlaybackStart)
                                    name:AVPlayerItemTimeJumpedNotification];

    // 播放结束
    [NSNotificationCenter lc_addObserver:self
                                selector:@selector(lc_moviePlaybackComplete)
                                    name:AVPlayerItemDidPlayToEndTimeNotification];

    // 视频中断
    [NSNotificationCenter lc_addObserver:self
                                selector:@selector(lc_moviePlaybackStalled)
                                    name:AVPlayerItemPlaybackStalledNotification];
}

/// 设置 Player
- (void)setupPlayer {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Launch.mov" ofType:nil];
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:filePath]];
    self.showsPlaybackControls = NO;
    [self.player play];
}



#pragma mark - ------ 监听方法 ------
/// 开始播放
- (void)lc_moviePlaybackStart {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bgImgView removeFromSuperview];
        self.bgImgView = nil;
    });
}


/// 播放结束
- (void)lc_moviePlaybackComplete {

    // 切换根视图
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = [[LCTabBarController alloc] init];
    [app.window makeKeyAndVisible];
}

/// 视频中断
- (void)lc_moviePlaybackStalled {

    NSLog(@"视频中断");
}

@end
