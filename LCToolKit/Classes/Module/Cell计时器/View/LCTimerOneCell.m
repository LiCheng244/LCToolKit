//
//  LCTimerOneCell.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/10.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCTimerOneCell.h"

@interface LCTimerOneCell ()

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation LCTimerOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    if (@available(iOS 10.0, *)) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSString *str = [NSDate lc_currentDateWithFormat:@"HH:MM:SS"];
            self.label.text = str;
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
