//
//  NSDictionary+LCExtension.h
//  LSLoginSDK
//
//  Created by LiCheng on 2017/7/11.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LCExtension)

@end



#pragma mark - ------ 解析相关 ------
@interface NSDictionary (JSON)

/**
 将 json格式字符串 转成 字典

 @param str     json 字符串
 @return json 字典
 */
+ (NSDictionary *)lc_dictWithJSONStr:(NSString *)str;

@end
