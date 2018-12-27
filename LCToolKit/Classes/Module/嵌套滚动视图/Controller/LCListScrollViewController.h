//
//  LCListScrollViewController.h
//  LCToolKit
//
//  Created by LiCheng on 2018/4/11.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCListScrollViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionV;
@property (nonatomic, assign) BOOL    vcCanScroll;
@end
