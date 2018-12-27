//
//  UIImage+LCExtension.h
//  LSSDK_DEV
//
//  Created by LiCheng on 2017/7/25.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LCExtension)

/**
 从 bundle 中加载图片

 @param name    图片名字
 */
+ (nullable UIImage *)lc_bundleImageNamed:(NSString *_Nullable)name;

@end
