//
//  LCListModel.h
//  LCToolKit
//
//  Created by LiCheng on 2018/12/7.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCListModel : NSObject

@property (nonatomic, copy) NSString *placeholderImage;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *views;
@property (nonatomic, copy) NSString *likes;

@end

NS_ASSUME_NONNULL_END
