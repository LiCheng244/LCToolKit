//
//  LCLinkageListCell.h
//  LCToolKit
//
//  Created by LiCheng on 2018/12/7.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCListModel;
NS_ASSUME_NONNULL_BEGIN

@interface LCLinkageListCell : UITableViewCell

@property (nonatomic, strong) LCListModel *model;
@end

NS_ASSUME_NONNULL_END
