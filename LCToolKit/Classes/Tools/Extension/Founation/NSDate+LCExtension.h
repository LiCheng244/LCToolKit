//
//  NSDate+Extension.h
//  demo
//
//  Created by LiCheng on 2017/4/6.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LCExtension)

/**
 根据给定的日期格式生成当前时间格式化字符串

 @param format          时间格式
 @return 时间格式化字符串
 */
+ (NSString *)lc_currentDateWithFormat:(NSString *)format;




/**
 将时间戳转换成时间格式

 @param timestamp       时间戳
 @return 时间格式字符串
 */
+ (NSString *)lc_timeWithTimestamp:(NSString *)timestamp ;



/**
 判断是否是今天

 @return YES:是 NO:不是
 */
- (BOOL)lc_isToday;


/**
 *  判断当前时间是否处于某个时间段内
 *
 *  @param sMinute      开始时间
 *  @param eMinute      结束时间
 */
- (BOOL)lc_isBetweenSMinute:(NSInteger)sMinute andEMinute:(NSInteger)eMinute ;

@end
