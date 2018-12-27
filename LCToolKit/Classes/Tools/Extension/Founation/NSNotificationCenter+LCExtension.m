//
//  NSNotificationCenter+LCExtension.m
//  LSLoginSDK
//
//  Created by LiCheng on 2017/7/12.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "NSNotificationCenter+LCExtension.h"

@implementation NSNotificationCenter (LCExtension)

@end

@implementation NSNotificationCenter (Notification)

/// 创建监听
+ (void)lc_postNotificationName:(NSNotificationName _Nullable )name info:(nullable NSDictionary *)info {

    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:info];
}



/// 添加监听
+(void)lc_addObserver:(id)observer selector:(SEL)selector name:(NSString *)name {

    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:nil];
}
@end
