//
//  HomeListHeaderView.h
//  ZWW
//
//  Created by LiCheng on 2017/11/5.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate;


#pragma mark - ------ 属性 ------

@interface HeaderView : UIView


/// 当前选中标题索引，默认0
@property (nonatomic, assign) NSInteger selectIndex;
/// 标题数据
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) id<HeaderViewDelegate> delegate;


@end


#pragma mark - ------ 代理方法 ------
@protocol HeaderViewDelegate <NSObject>

/**
 切换标题

 @param view        FSSegmentTitleView
 @param startIndex  切换前标题索引
 @param endIndex    切换后标题索引
 */
- (void)headerView:(HeaderView *)view startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

/**
 开始拖拽
 */
- (void)headerViewWillBeginDraggin:(HeaderView *)view;


/**
 结束拖拽
 */
- (void)headerViewDidEndDecelerating:(HeaderView *)view;


@end
