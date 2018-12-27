//
//  UITableView+LCExtension.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/7.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "UITableView+LCExtension.h"

@implementation UITableView (LCExtension)

/// 注册 cell
- (void)lc_registerNibName:(Class)cellClass {
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(cellClass)];
}


/// 注册 cell
- (void)lc_registerNibName:(Class)cellClass reuseIdentifier:(NSString *)identifier {
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:identifier];
}

@end
