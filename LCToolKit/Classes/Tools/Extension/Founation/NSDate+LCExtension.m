//
//  NSDate+Extension.m
//  demo
//
//  Created by LiCheng on 2017/4/6.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "NSDate+LCExtension.h"

@implementation NSDate (LCExtension)

///  根据给定的日期格式生成当前时间格式化字符串
+ (NSString *)lc_currentDateWithFormat:(NSString *)format {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];

    return [dateFormatter stringFromDate:[NSDate date]];
}


///  将时间戳转换成时间格式
+ (NSString *)lc_timeWithTimestamp:(NSString *)timestamp {

    // 格式化时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];

    // 毫秒值转化为秒
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


/// 判断是否是今天
- (BOOL)lc_isToday {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | kCFCalendarUnitMinute;

    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];

    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];

    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}


/// 判断当前时间是否处于某个时间段内
- (BOOL)lc_isBetweenSMinute:(NSInteger)sMinute andEMinute:(NSInteger)eMinute {


    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute;

    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];

    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];

    if ((selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day)) {

        if (selfCmps.hour == nowCmps.hour) {

            if (selfCmps.minute >= sMinute && selfCmps.minute <= eMinute) {
                return  YES;

            } else {
                return NO;
            }

        } else {
            return NO;
        }

    }else {

        return NO;
    }
}
@end
