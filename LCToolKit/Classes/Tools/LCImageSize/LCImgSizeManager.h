//
//  ImgSizeManager.h
//  LCToolKit
//
//  Created by LiCheng on 2018/12/17.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

/**
 实际使用的类。管理操作队列，缓存，管理 URLSession
 */

#import <Foundation/Foundation.h>
typedef void (^SuccBlock)(id response);
typedef void (^FailBlock)(NSString *eInfo);
NS_ASSUME_NONNULL_BEGIN

@interface LCImgSizeManager : NSObject



- (void)getSizeWithImgUrl:(NSURL *)url force:(BOOL)force succ:(SuccBlock)succ fail:(FailBlock)fail;
@end

NS_ASSUME_NONNULL_END
