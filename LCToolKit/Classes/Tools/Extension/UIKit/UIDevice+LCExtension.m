//
//  UIDevice+LCExtension.m
//  LSSDK_DEV
//
//  Created by LiCheng on 2017/8/1.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "UIDevice+LCExtension.h"
#import "sys/utsname.h"
#import <Security/Security.h>
#import "KeychainItemWrapper.h"


@implementation UIDevice (LCExtension)

@end


@implementation UIDevice (AppInfo)

/// app 名称
+ (NSString *)lc_appName {

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleName"];
}


/// app 版本  例如: 1.0.1
+ (NSString *)lc_appVersion {

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleShortVersionString"];
}


/// app build 号
+ (NSString *)lc_appBuild {

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleVersion"];
}


/// 唯一标识符
+ (NSString *)lc_appBundleId {

    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return [infoDict objectForKey:@"CFBundleIdentifier"];
}



@end


@implementation UIDevice (Device)


/// 设备用户名称
+ (NSString *)lc_deviceUserName {

    UIDevice *device = [[UIDevice alloc] init];
    return device.name;
}


/// 设备类型
+ (NSString *)lc_deviceModel {

    UIDevice *device = [[UIDevice alloc] init];
    return device.model;
}


/// 系统版本
+ (NSString *)lc_systemVersion {

    UIDevice *device = [[UIDevice alloc] init];
    return device.systemVersion;
}


/// 系统名称
+ (NSString *)lc_systemName {

    UIDevice *device = [[UIDevice alloc] init];
    return device.systemName;
}


/// 设备唯一标示符
+ (NSString *)lc_UUID {

    KeychainItemWrapper *key = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:@"com.lc.toolkit"];
    NSString *str;
    NSString *uuidStr = [key objectForKey:(id)kSecValueData];

    if (uuidStr.length == 0) {

        NSString *strUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [key setObject:strUUID forKey:(__bridge id)kSecValueData];
        str = strUUID;

    }else {
        str = [key objectForKey:(id)kSecValueData];
    }

    return str;
}


/// 国家
+(NSString *)lc_country {

    NSLocale *locale = [NSLocale currentLocale];
    return [locale localeIdentifier];
}


/// 电量 -1:模拟器  0-1:真机
+(CGFloat)lc_batteryLevel {

    UIDevice *device = [UIDevice currentDevice];
    return [device batteryLevel];
}


/// 设备分辨率
+ (NSString *)lc_resolution {

    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGFloat scale = [UIScreen mainScreen].scale;

    CGFloat width = size.width * scale;
    CGFloat height = size.height * scale;

    return [NSString stringWithFormat:@"%.0f*%.0f", width, height];
}


/// 手机设备名称
+ (NSString *)lc_deviceName {

    struct utsname systemInfo;
    uname(&systemInfo);

    NSString *deviceStr = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if ([deviceStr isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([deviceStr isEqualToString:@"iPhone3,2"])    return @"iPhone4";
    if ([deviceStr isEqualToString:@"iPhone3,3"])    return @"iPhone4";
    if ([deviceStr isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([deviceStr isEqualToString:@"iPhone5,1"])    return @"iPhone5";
    if ([deviceStr isEqualToString:@"iPhone5,2"])    return @"iPhone5";
    if ([deviceStr isEqualToString:@"iPhone5,3"])    return @"iPhone5c";
    if ([deviceStr isEqualToString:@"iPhone5,4"])    return @"iPhone5c";
    if ([deviceStr isEqualToString:@"iPhone6,1"])    return @"iPhone5s";
    if ([deviceStr isEqualToString:@"iPhone6,2"])    return @"iPhone5s";
    if ([deviceStr isEqualToString:@"iPhone7,1"])    return @"iPhone6 Plus";
    if ([deviceStr isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([deviceStr isEqualToString:@"iPhone8,1"])    return @"iPhone6s";
    if ([deviceStr isEqualToString:@"iPhone8,2"])    return @"iPhone6s Plus";
    if ([deviceStr isEqualToString:@"iPhone8,4"])    return @"iPhoneSE";

    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceStr isEqualToString:@"iPhone9,1"])    return @"iPhone7";
    if ([deviceStr isEqualToString:@"iPhone9,2"])    return @"iPhone7 Plus";
    if ([deviceStr isEqualToString:@"iPhone9,3"])    return @"iPhone7";
    if ([deviceStr isEqualToString:@"iPhone9,4"])    return @"iPhone7 Plus";

    if ([deviceStr isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceStr isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceStr isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceStr isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceStr isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceStr isEqualToString:@"iPhone10,6"])   return @"iPhone X";

    if ([deviceStr isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceStr isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceStr isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceStr isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceStr isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";

    if ([deviceStr isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceStr isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceStr isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([deviceStr isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceStr isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([deviceStr isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceStr isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([deviceStr isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceStr isEqualToString:@"iPad2,7"])      return @"iPad Mini";
    if ([deviceStr isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([deviceStr isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([deviceStr isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceStr isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([deviceStr isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceStr isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([deviceStr isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceStr isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceStr isEqualToString:@"iPad4,4"])      return @"iPad Mini 2";
    if ([deviceStr isEqualToString:@"iPad4,5"])      return @"iPad Mini 2";
    if ([deviceStr isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceStr isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceStr isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceStr isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceStr isEqualToString:@"iPad5,1"])      return @"iPad Mini 4";
    if ([deviceStr isEqualToString:@"iPad5,2"])      return @"iPad Mini 4";
    if ([deviceStr isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceStr isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceStr isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceStr isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceStr isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceStr isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";

    if ([deviceStr isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceStr isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceStr isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceStr isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";

    if ([deviceStr isEqualToString:@"i386"])         return @"i386Simulator";
    if ([deviceStr isEqualToString:@"x86_64"])       return @"x86_64Simulator";
    
    return deviceStr;
}

@end
