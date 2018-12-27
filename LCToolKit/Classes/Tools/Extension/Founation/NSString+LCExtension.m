//
//  NSString+LCExtension.m
//  LSLoginSDK
//
//  Created by LiCheng on 2017/7/4.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "NSString+LCExtension.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (LCExtension)

@end


@implementation NSString (RegExp)

/// 判断字符串是否为空
+ (BOOL)lc_isNull:(NSString *)str {

    if (str == nil || str == NULL || str.length == 0 || [str isKindOfClass:[NSNull class]]) {
        return YES;
    }else {
        return NO;
    }
}


/// 是否是字符串
- (BOOL)lc_isNumStr{

    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(str.length > 0)
    {
        return NO;
    }
    return YES;
}


/// 字符串是否以字母开头
- (BOOL)lc_isLetterPrefix {

    return [self baseWithRegExp:@"^[A-Za-z].+$"];
}


/// 是否是手机号
- (BOOL)lc_isMobile {

    if (self.length != 11) {

        return NO;
    }

    return [self baseWithRegExp:@"^1[3|4|5|7|8][0-9]\\d{8}$"];
}


/// 是否是邮箱
-(BOOL)lc_isEmail {

    return [self baseWithRegExp:@"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}


/// 身份证验证
- (BOOL)lc_idCard {

    //长度不为18的都排除掉
    if (self.length!=18) {
        return NO;
    }

    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:self];

    if (!flag) {
        return flag;    //格式错误
    }else {

        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];

        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];

        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++) {

            NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];

            idCardWiSum+= subStrIndex * idCardWiIndex;
        }

        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;

        //得到最后一位身份证号码
        NSString * idCardLast= [self substringWithRange:NSMakeRange(17, 1)];

        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2) {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                return YES;
            } else {
                return NO;
            }
        } else {
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                return YES;
            } else {
                return NO;
            }
        }
    }
}



/// 判断是否是中文
- (BOOL)lc_chinese {
    return [self baseWithRegExp:@"[\u4e00-\u9fa5]+"];
}


- (BOOL)baseWithRegExp:(NSString *)regexp {

    if (self.length <= 0 || self == nil) {
        return NO;
    }

    if (regexp.length <= 0 || regexp == nil) {
        return NO;
    }

    NSPredicate *idCard = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexp];
    return [idCard evaluateWithObject:self];
}

@end


#pragma mark - ------ 加密解密相关 ------
@implementation NSString (Encryption)


/// 生成一个随机的密码
+(NSString *)lc_randomStr {
    static int kNumber = 15;

    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


/// 32位 md5 小写加密
- (NSString *)lc_md5{

    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);

    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }

    return digest;
}


/// 异或加密
-(NSString *)lc_xorEncrypt {
    NSData *data =[self dataUsingEncoding:NSUTF8StringEncoding];

    char *dataP = (char *)[data bytes];
    for (int i = 0; i < data.length; i++) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunsequenced"
        *dataP = *(++dataP) ^ 1;
#pragma clang diagnostic pop
    }

    NSString *str = [[NSString alloc] initWithData:(data) encoding:NSUTF8StringEncoding];
    return str;
}


/// 异或解密
-(NSString *)lc_xorDecipher {

    NSData *data =[self dataUsingEncoding:NSUTF8StringEncoding];

    char *dataP = (char *)[data bytes];
    for (int i = 0; i < data.length; i++) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunsequenced"
        *dataP = *(++dataP) ^ 1;
#pragma clang diagnostic pop
    }

    NSString *str = [[NSString alloc] initWithData:(data) encoding:NSUTF8StringEncoding];
    return str;
}

@end


@implementation NSString (RichText)

/// 富文本字符串
+(NSAttributedString *)lc_attrStr:(NSString *)str range:(NSRange)range color:(UIColor *)color {

    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];

    [attributedStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return [attributedStr copy];
}



@end
