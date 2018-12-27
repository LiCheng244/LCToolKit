//
//  UICollectionView+LCExtension.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/14.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "UICollectionView+LCExtension.h"

@implementation UICollectionView (LCExtension)


/// 注册 cell
- (void)lc_registerNibName:(Class)cellClass {
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}


/// 注册 cell
- (void)lc_registerNibName:(Class)cellClass reuseIdentifier:(NSString *)identifier {
    
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellWithReuseIdentifier:identifier];
}


@end
