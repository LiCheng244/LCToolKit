//
//  LCVersionUpdateManager.h
//  LCToolKit
//
//  Created by LiCheng on 2018/4/13.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCVersionUpdateManager : NSObject


/**
 *  版本更新
 *
 *  @param appid              该app的id (在itunes connect中获取)
 *  @param isShowDetail       是否显示版本更新详情
 *  @param controller         要显示的controller
 */
+ (void)versionUpdateForAppID:(NSString *)appid
                 isShowDetail:(BOOL)isShowDetail
               showController:(UIViewController *)controller;

@end
