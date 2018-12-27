//
//  LCLinkageListCell.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/7.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCLinkageListCell.h"
#import "LCListModel.h"

@interface LCLinkageListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *auther;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation LCLinkageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(LCListModel *)model {
  
    _model = model;
    
    _img.image = [UIImage imageNamed:_model.placeholderImage];
//    [self.img sd_setImageWithURL:[NSURL URLWithString:_model.picUrl]  placeholderImage:_model.placeholderImage];
    self.title.text = _model.title;
    self.auther.text = _model.author;
    self.label1.text = _model.views;
    self.label2.text = _model.likes;
}


@end
