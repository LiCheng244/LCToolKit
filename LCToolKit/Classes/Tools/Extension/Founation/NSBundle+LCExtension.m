//
//  NSBundle+Extension.m
//  LSLoginSDK
//
//  Created by LiCheng on 2017/5/8.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "NSBundle+LCExtension.h"

@implementation NSBundle (LCExtension)

/**
 从 bundle 中获取资源
 */
+ (instancetype)bundle {

    NSString *path     = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"LSGameSDK.bundle"];
    NSBundle *myBundle = [NSBundle bundleWithPath:path];

    if (myBundle == nil) {
        return [NSBundle mainBundle];
    }else{
        return myBundle;
    }
}

@end


@implementation NSBundle (Info)

/**
 根据 ID 获取URL Types 中的 URL Schemes
 */
+(NSString *)lc_getUrlSchemesWithID:(NSString *)identifier {

    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];

    NSMutableArray *urlTypes = [infoDic objectForKey:@"CFBundleURLTypes"];

    for (NSDictionary *dict in urlTypes) {

        NSString *urlName = [dict objectForKey:@"CFBundleURLName"];

        if ([urlName isEqualToString:identifier]) {
            NSArray *urlSchemes = [dict objectForKey:@"CFBundleURLSchemes"];
            NSString *str = urlSchemes[0];
            return str;
        }
    }
    return nil;
}


@end
