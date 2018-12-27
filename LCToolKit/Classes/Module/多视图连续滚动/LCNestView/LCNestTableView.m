//
//  LCNestTableView.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCNestTableView.h"
#import "LCNestView.h"

@implementation LCNestTableView

/// 是否允许外层 tableView 的手势传递到子视图
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    
    CGFloat contentViewHeight = SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAV_BAR_HEIGHT - SEGMENT_HEIGHT;
    
    CGPoint currentPoint = [gestureRecognizer locationInView:self];
    
    if (CGRectContainsPoint(CGRectMake(0, self.contentSize.height - contentViewHeight, SCREEN_WIDTH, contentViewHeight), currentPoint)) {
        return YES;
    }
    return NO;
}


@end
