//
//  UIColor+Extension.m
//  LSLoginSDK
//
//  Created by LiCheng on 2017/4/10.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "UIColor+LCExtension.h"

@implementation UIColor (LCExtension)


+ (UIColor *)lc_hexCodeColor:(NSString *)hexString {

    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];

    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }

    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }

    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];

    float red   = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue  = ((baseValue >> 8)  & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0)  & 0xFF)/255.0f;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)lc_baseColor {

    return [self lc_hexCodeColor:@"564E5F"];
}


+ (UIColor *)lc_randomColor {
  
    int R = (arc4random() % 256) ;
    int G = (arc4random() % 256) ;
    int B = (arc4random() % 256) ;

    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
}
@end
