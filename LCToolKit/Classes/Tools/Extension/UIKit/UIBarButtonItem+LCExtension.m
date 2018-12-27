//
//  UIBarButtonItem+LCExtension.m
//  LSSDK_DEV
//
//  Created by LiCheng on 2017/7/31.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "UIBarButtonItem+LCExtension.h"


@implementation UIBarButtonItem (LCExtension)

+ (UIBarButtonItem *)lc_barButtonItemWithImageNamed:(NSString *)imageName
                                             target:(id)target
                                             action:(SEL)action {


    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                   style:(UIBarButtonItemStyleDone)
                                                                  target:target
                                                                  action:action];
    return barBtnItem;
}
@end
