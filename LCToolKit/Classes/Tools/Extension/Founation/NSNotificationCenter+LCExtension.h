//
//  NSNotificationCenter+LCExtension.h
//  LSLoginSDK
//
//  Created by LiCheng on 2017/7/12.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (LCExtension)

@end

@interface NSNotificationCenter (Notification)


/**
 创建监听

 @param name        监听名字
 @param info        参数
 */
+(void)lc_postNotificationName:(NSNotificationName _Nullable )name
                          info:(nullable NSDictionary *)info;


/**
 添加监听

 @param observer    监听者
 @param selector    监听执行的方法
 @param name        名字
 */
+(void)lc_addObserver:(id _Nullable )observer
             selector:(SEL _Nullable )selector
                 name:(NSString *_Nullable)name;


@end
