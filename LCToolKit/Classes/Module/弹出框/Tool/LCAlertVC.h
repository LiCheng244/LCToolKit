//
//  LCAlertVC.h
//  LCToolKit
//
//  Created by LiCheng on 2018/2/1.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdvertAlertVCDeleagte <NSObject>

-(void)closeAdvertClick ;

@end

@interface LCAlertVC : UIViewController <UIViewControllerTransitioningDelegate>


+ (instancetype)fk_showAlertVCWithDelegate:(id<AdvertAlertVCDeleagte>)delegate;
@property (nonatomic, weak) id<AdvertAlertVCDeleagte> delegate;  // 代理
@end
