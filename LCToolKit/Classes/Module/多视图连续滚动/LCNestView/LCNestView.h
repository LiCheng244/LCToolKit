//
//  LCNestView.h
//  LCToolKit
//
//  Created by LiCheng on 2018/12/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#ifndef LCNestView_h
#define LCNestView_h


#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define NAV_BAR_HEIGHT  44
#define SEGMENT_HEIGHT  41


#define CurrentSelectedChildViewControllerIndex @"CurrentSelectedChildViewControllerIndex"
#define Scroll_Segment       @"ScrollSegment"       // 切换分页时禁止mainTableView上下滑动，停止分页左右滑动的时候允许mainTableView滑动
#define Segment_Chirld_ToTop @"SegmentChirldToTop"  // 回到顶部
#define Leave_Top            @"LeaveTop"            // 允许外层 tableView 滚动通知 - 解决和分页视图的上下滑动冲突问题
#define Back_Status          @"BackStatus"          //
#define SegementViewChildVCBackToTop @"segementViewChildVCBackToTop"
#define IsEnablePersonalCenterVCMainTableViewScroll @"IsEnablePersonalCenterVCMainTableViewScroll"
#endif /* LCNestView_h */
