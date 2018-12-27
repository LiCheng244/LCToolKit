//
//  FKHomeContainerCell.h
//  ZWW
//
//  Created by LiCheng on 2018/4/8.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContainerCell;

@protocol ContainerCellDelegate <NSObject>

@optional
- (void)containerCell:(ContainerCell *)cell scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)containerCell:(ContainerCell *)cell scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@interface ContainerCell : UITableViewCell

@property (nonatomic, weak) id <ContainerCellDelegate> delegate;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray      *childVCs;
@property (nonatomic, assign) BOOL         objectCanScroll;
@property (nonatomic, assign) BOOL         isSelectIndex;

@end



