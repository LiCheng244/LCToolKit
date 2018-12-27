//
//  HomeListLeftCell.m
//  ZWW
//
//  Created by LiCheng on 2017/11/5.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "FKHomeListCell.h"


@interface FKHomeListCell ()

@property (weak, nonatomic) IBOutlet UIView      *bgV;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel     *titleL;
@property (weak, nonatomic) IBOutlet UILabel     *priceL;
@property (weak, nonatomic) IBOutlet UILabel     *statusL;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgV;

@end

@implementation FKHomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bgV.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5,5)];//圆角大小
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgV.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.bgV.layer.mask = maskLayer;
}




@end
