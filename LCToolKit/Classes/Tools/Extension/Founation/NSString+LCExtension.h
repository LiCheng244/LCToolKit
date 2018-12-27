//
//  NSString+LCExtension.h
//  LSLoginSDK
//
//  Created by LiCheng on 2017/7/4.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString (LCExtension)
@end

#pragma mark - ------ 正则验证相关 ------

@interface NSString (RegExp)


/**
 判断字符串是否为空
 */
+ (BOOL)lc_isNull:(NSString *)str;


/**
 是否是字符串
 */
- (BOOL)lc_isNumStr;


/**
 字符串是否以字母开头
 */
- (BOOL)lc_isLetterPrefix;


/**
 是否是手机号

 @return YES:是 NO:否
 */
- (BOOL)lc_isMobile;


/**
 邮箱验证
 
 @return YES:是 NO:否
 */
- (BOOL)lc_isEmail;


/**
 身份证验证

 @return YES:是 NO:否
 */
- (BOOL)lc_idCard;


/**
 判断是否是中文

 @return YES:是 NO:否
 */
- (BOOL)lc_chinese;

@end



#pragma mark - ------ 加密解密相关 ------

@interface NSString (Encryption)

/**
 生成一个随机密码

 @return 随机密码
 */
+(NSString *)lc_randomStr;


/**
 MD5 32位小写 加密
 
 @return 加密后的字符串
 */
- (NSString *)lc_md5;


/**
 异或加密

 @return 加密后的字符串
 */
-(NSString *)lc_xorEncrypt;


/**
 异或解密
 
 @return 加密后的字符串
 */
-(NSString *)lc_xorDecipher;

@end


#pragma mark - ------ 富文本相关 ------
@interface NSString (RichText)

/**
 富文本字符串

 @param str     字符串
 @param range   富文本位置
 @param color   字体颜色

 @return 新的富文本字符串
 */
+(NSAttributedString *)lc_attrStr:(NSString *)str
                            range:(NSRange)range
                            color:(UIColor *)color;

@end
