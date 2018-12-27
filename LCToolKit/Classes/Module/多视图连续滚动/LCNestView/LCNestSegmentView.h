//
//  LCNestSegmentView.h
//  LCToolKit
//
//  Created by LiCheng on 2018/12/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCNestSegmentView : UIView

@property (nonatomic, strong) NSArray *chirldVCs;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) id parentVC;

@end

NS_ASSUME_NONNULL_END
