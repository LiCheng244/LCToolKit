//
//  UICollectionView+LCExtension.h
//  LCToolKit
//
//  Created by LiCheng on 2018/12/14.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (LCExtension)

/**
 注册 cell
 
 @param cellClass       cell 类
 */
- (void)lc_registerNibName:(Class)cellClass;



/**
 注册 cell
 
 @param cellClass       cell 类
 @param identifier      标示
 */
- (void)lc_registerNibName:(Class)cellClass reuseIdentifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END
