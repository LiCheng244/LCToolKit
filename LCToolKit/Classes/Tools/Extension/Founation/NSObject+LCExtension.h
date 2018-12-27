//
//  NSObject+LCExtension.h
//  LSLoginSDK
//
//  Created by LiCheng on 2017/7/18.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (LCExtension)

@end


@interface NSObject (ViewController)

/**
 获取当前根视图控制器

 @return 根视图控制器
 */
+ (instancetype)lc_currentRootController;
@end
