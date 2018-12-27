//
//  LCTableView.m
//  LCToolKit
//
//  Created by LiCheng on 2018/4/11.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCTableView.h"

@implementation LCTableView


/// 允许识别多手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    return YES;
}


@end
