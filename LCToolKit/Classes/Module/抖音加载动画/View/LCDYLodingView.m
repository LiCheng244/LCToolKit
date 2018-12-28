//
//  LCDYLodingView.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/28.
//  Copyright © 2018 LiCheng. All rights reserved.
//

#import "LCDYLodingView.h"

static CGFloat BallWidth     = 12.0f;       // 球宽
static CGFloat BallSpeed     = 0.7f;        // 球速
static CGFloat BallZoomScale = 0.25;        // 球缩放比例
static CGFloat PauseSecond   = 0.15;        // 暂停时间 s


@interface LCDYLodingView ()

@property (nonatomic, strong) UIView        *bgV;          // 背景视图
@property (nonatomic, strong) UIView        *redBallV;     // 红色圆球
@property (nonatomic, strong) UIView        *greenBallV;   // 绿色圆球
@property (nonatomic, strong) UIView        *blackBallV;   // 黑色圆球
@property (nonatomic, strong) CADisplayLink *displayLink;  // 定时器
@property (nonatomic, assign) BOOL          isDirection;   // 正向运动
@end

@implementation LCDYLodingView

#pragma mark - ------ Pubilc Methods ------

/// 显示
+ (void)showLodingInView:(UIView *)view {
    
    LCDYLodingView *loding = [[LCDYLodingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    loding.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - 64);

    [view addSubview:loding];
}

/// 隐藏
+ (void)hideLodingInView:(UIView *)view {
    
    NSEnumerator *subViews = [view.subviews reverseObjectEnumerator];
    
    for (UIView *view in subViews) {
        
        if ([view isKindOfClass:self]) {
            LCDYLodingView *loding = (LCDYLodingView *)view;
            [loding.displayLink invalidate];
            [loding removeFromSuperview];
            return;
        }
    }
}

#pragma mark - ------ Lazyloding Methods ------

- (UIView *)bgV {
    
    if(!_bgV) {
        
        _bgV = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, BallWidth*2, BallWidth*2))];
        _bgV.center = self.center;
    }
    return _bgV;
}

- (UIView *)redBallV {
    
    if(!_redBallV) {
        
        _redBallV = [[UIView alloc] init];
        _redBallV.lc_size = CGSizeMake(BallWidth, BallWidth);
        _redBallV.center = CGPointMake(_bgV.lc_width - BallWidth/2, _bgV.lc_height/2);
        _redBallV.layer.cornerRadius = BallWidth/2;
        _redBallV.layer.masksToBounds = YES;
        _redBallV.backgroundColor = [UIColor colorWithRed:255/255.0f green:46/255.0f blue:86/255.0f alpha:1];
    }
    return _redBallV;
}

- (UIView *)blackBallV {
    
    if(!_blackBallV) {
        
        _blackBallV = [[UIView alloc] init];
        _blackBallV.lc_size = CGSizeMake(BallWidth, BallWidth);
        _blackBallV.center = CGPointMake(BallWidth/2, _bgV.lc_height/2);
        _blackBallV.layer.cornerRadius = BallWidth/2;
        _blackBallV.layer.masksToBounds = YES;
        _blackBallV.backgroundColor = [UIColor colorWithRed:12/255.0f green:11/255.0f blue:17/255.0f alpha:1];
    }
    return _blackBallV;
}

- (UIView *)greenBallV {
    
    if(!_greenBallV) {
        
        _greenBallV = [[UIView alloc] init];
        _greenBallV.lc_size = CGSizeMake(BallWidth, BallWidth);
        _greenBallV.center = CGPointMake(BallWidth/2, _bgV.lc_height/2);
        _greenBallV.layer.cornerRadius = BallWidth/2;
        _greenBallV.layer.masksToBounds = YES;
        _greenBallV.backgroundColor = [UIColor colorWithRed:35/255.0f green:246/255.0f blue:235/255.0f alpha:1];
    }
    return _greenBallV;
}


#pragma mark - ------ System Methods ------

- (instancetype)initWithFrame:(CGRect)frame {
  
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUILayout];
    }
    
    return self;
}

#pragma mark - ------ UILayout Methods ------
- (void)setupUILayout {
    
    self.backgroundColor = [UIColor clearColor];
    
    // 第一次动画，绿球在上、红球在下、黑色阴影在绿球上
    [self addSubview:self.bgV];
    [self.bgV addSubview:self.greenBallV];
    [self.bgV addSubview:self.redBallV];
    [self.greenBallV addSubview:self.blackBallV];
    self.isDirection = YES;
    
    // 定时器
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateBallAnimation)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}


/// 更新动画
- (void)updateBallAnimation {
    
    if (self.isDirection) {
        [self setupPositiveSportLayout];
    } else {
        [self setupNegativeSportLayout];
    }
}

/// 正向运动布局
- (void)setupPositiveSportLayout {
    
    // 更新绿球
    self.greenBallV.lc_centerX += BallSpeed;
    
    // 更新红球
    self.redBallV.lc_centerX  -= BallSpeed;
    
    // 缩放动画
    self.greenBallV.transform = [self largerTransformOfCenterX:self.redBallV.lc_centerX];
    self.redBallV.transform   = [self smallerTransformOfCenterX:self.redBallV.lc_centerX];

    // 更新黑球     相对于可见区域转换区域
    CGRect blackBallF = [self.redBallV convertRect:self.redBallV.bounds toCoordinateSpace:self.greenBallV];
    self.blackBallV.frame = blackBallF;
    self.blackBallV.layer.cornerRadius = self.blackBallV.lc_width/2;
    
    // 更新方向
    if (CGRectGetMaxX(self.greenBallV.frame) >= self.bgV.lc_width ||
        CGRectGetMinX(self.redBallV.frame) <= 0) {
        
        // 更改方向标签
        self.isDirection = NO;
        // 反向运动时  红球在上 绿球在下
        [self.bgV bringSubviewToFront:self.redBallV];
        // 黑球放在红球上面
        [self.redBallV addSubview:self.blackBallV];
        // 暂停一下
        [self pauseAnimation];
    }
}


/// 逆向运动
- (void)setupNegativeSportLayout {
    
    // 更新绿球
    self.greenBallV.lc_centerX -= BallSpeed;
    
    // 更新红球
    self.redBallV.lc_centerX += BallSpeed;
    
    // 缩放动画
    self.redBallV.transform   = [self largerTransformOfCenterX:self.redBallV.lc_centerX];
    self.greenBallV.transform = [self smallerTransformOfCenterX:self.redBallV.lc_centerX];
    
    // 更新黑球
    CGRect blackBallF = [self.greenBallV convertRect:self.greenBallV.bounds toCoordinateSpace:self.redBallV];
    self.blackBallV.frame = blackBallF;
    self.blackBallV.layer.cornerRadius = self.blackBallV.lc_width/2;
    
    // 更新方向
    if (CGRectGetMaxX(self.redBallV.frame) >= self.bgV.lc_width ||
        CGRectGetMinX(self.greenBallV.frame) <= 0) {
        
        // 更改方向标签
        self.isDirection = YES;
        // 反向运动时  红球在上 绿球在下
        [self.bgV bringSubviewToFront:self.greenBallV];
        // 黑球放在红球上面
        [self.greenBallV addSubview:self.blackBallV];
        // 暂停一下
        [self pauseAnimation];
    }
}

/// 暂停
- (void)pauseAnimation {
    
    self.displayLink.paused = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(PauseSecond * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.displayLink.paused = NO;
    });
}

/// 放大动画
- (CGAffineTransform)largerTransformOfCenterX:(CGFloat)centerX {
    CGFloat cosValue = [self cosValueOfCenterX:centerX];
    return CGAffineTransformMakeScale(1 + cosValue*BallZoomScale, 1 + cosValue*BallZoomScale);
}

/// 缩小动画
- (CGAffineTransform)smallerTransformOfCenterX:(CGFloat)centerX {
    CGFloat cosValue = [self cosValueOfCenterX:centerX];
    return CGAffineTransformMakeScale(1 - cosValue*BallZoomScale, 1 - cosValue*BallZoomScale);
}

/// 根据余弦函数获取变化区间 变化范围是0~1~0
- (CGFloat)cosValueOfCenterX:(CGFloat)centerX {
    
    CGFloat apart = centerX - self.bgV.lc_width/2.0f;
    //最大距离(球心距离Container中心距离)
    CGFloat maxAppart = (self.bgV.lc_width - BallWidth)/2.0f;
    //移动距离和最大距离的比例
    CGFloat angle = apart/maxAppart*M_PI_2;
    //获取比例对应余弦曲线的Y值
    
    return cos(angle);
}

@end
