//
//  LCNestCarouselView.h
//  LCToolKit
//
//  Created by LiCheng on 2018/12/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LCCarouselViewDelegate;


NS_ASSUME_NONNULL_BEGIN

#pragma mark - ------ Property ------

@interface LCNestCarouselView : UIView

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, assign) id<LCCarouselViewDelegate> delegate;

/// 暂停轮播
- (void)stopCarousel;

/// 恢复轮播
- (void)recoverCarousel;

@end



#pragma mark - ------ Delegate ------

@protocol LCCarouselViewDelegate <NSObject>

@optional

/// 点击轮播图
- (void)lc_carouselView:(LCNestCarouselView *)view didSelectItemAtIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
