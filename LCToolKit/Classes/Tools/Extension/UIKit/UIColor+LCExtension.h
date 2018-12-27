//
//  UIColor+Extension.h
//  LSLoginSDK
//
//  Created by LiCheng on 2017/4/10.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LCExtension)



/**
 16进制颜色

 @param hexString 16进制
 */
+ (UIColor *)lc_hexCodeColor:(NSString *)hexString;


+ (UIColor *)lc_baseColor;

+ (UIColor *)lc_randomColor;
@end
