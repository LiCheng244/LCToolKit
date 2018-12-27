//
//  NSBundle+Extension.h
//  LSLoginSDK
//
//  Created by LiCheng on 2017/5/8.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (LCExtension)

/**
 从 bundle 中获取资源
 */
+ (instancetype)bundle;

@end


#pragma mark - ------ 获取 info 中的信息------
@interface NSBundle (Info)


/**
 根据 ID 获取URL Types 中的 URL Schemes

 @param identifier      id 标识
 @return URL Schemes    字符串
 */
+ (NSString *)lc_getUrlSchemesWithID:(NSString *)identifier;

@end
