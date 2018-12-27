//
//  LCMineHeaderCell.m
//  LCToolKit
//
//  Created by LiCheng on 2017/12/11.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCMineHeaderCell.h"

@implementation LCMineHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
