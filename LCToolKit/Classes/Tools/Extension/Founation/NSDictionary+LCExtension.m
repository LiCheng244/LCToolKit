//
//  NSDictionary+LCExtension.m
//  LSLoginSDK
//
//  Created by LiCheng on 2017/7/11.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "NSDictionary+LCExtension.h"

@implementation NSDictionary (LCExtension)

@end


@implementation NSDictionary (JSON)

/// 将json 格式字符串转成字典
+ (NSDictionary *)lc_dictWithJSONStr:(NSString *)str {

    if (str == nil) {
        return nil;
    }

    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        
        return nil;
    }
    return dic;
}

@end
