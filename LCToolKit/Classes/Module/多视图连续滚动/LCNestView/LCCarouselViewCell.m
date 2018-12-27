//
//  LCarouselViewCell.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/14.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCCarouselViewCell.h"

@interface LCCarouselViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;

@end

@implementation LCCarouselViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItemData:(NSString *)itemData {
    
    _itemData = itemData;
    
    if (_itemData) {
        _imgV.image = [UIImage imageNamed:itemData];
    }
}


@end
