//
//  UIImage+LCExtension.m
//  LSSDK_DEV
//
//  Created by LiCheng on 2017/7/25.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "UIImage+LCExtension.h"

@implementation UIImage (LCExtension)


/// 从 bundle 中加载图片
+ (nullable UIImage *)lc_bundleImageNamed:(NSString *_Nullable)name {

    NSString *path     = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"LSGameSDK.bundle"];
    NSBundle *myBundle = [NSBundle bundleWithPath:path];

    if (myBundle != nil) {
        name = [NSString stringWithFormat:@"LSGameSDK.bundle/%@", name];
    }
    UIImage *image = [UIImage imageNamed:name];

    return image;
}
@end
