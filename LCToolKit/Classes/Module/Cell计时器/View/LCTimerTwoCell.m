//
//  LCTimerTwoCell.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/10.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCTimerTwoCell.h"

@interface LCTimerTwoCell ()

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation LCTimerTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        if (@available(iOS 10.0, *)) {
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                NSString *str = [NSDate lc_currentDateWithFormat:@"HH:MM:SS"];
                
                // 回到主线程
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.label.text = str;
                });
            }];
            
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            [[NSRunLoop currentRunLoop] run];
            
        } else {
            // Fallback on earlier versions
        }
    });
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
