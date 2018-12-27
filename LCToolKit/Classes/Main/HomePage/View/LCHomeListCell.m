//
//  LCHomeListCell.m
//  LCToolKit
//
//  Created by LiCheng on 2017/12/12.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "LCHomeListCell.h"

@interface LCHomeListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation LCHomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModule:(NSDictionary *)module {

    _module = module;
    self.titleL.text = module[@"title"];
}

@end
