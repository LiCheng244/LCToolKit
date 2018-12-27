//
//  LCImgSizeParser.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/17.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCImgSizeParser.h"

@interface LCImgSizeParser ()

@end


@implementation LCImgSizeParser



- (CGSize)getImageSizeWithData:(NSData *)data imgType:(NSString *)type {
    
    Byte *bytes = (Byte*)[data bytes];
    // jpeg, png, gif, bmp
    if ([type isEqualToString:@"bmp"]) {
        
        NSInteger length = 0;
        [data getBytes:&length range:NSMakeRange(14, 4)];
        
        CGFloat w = 0;
        CGFloat h = 0;
        [data getBytes:&w range:(length == 12 ? NSMakeRange(18, 4) : NSMakeRange(18, 2))];
        [data getBytes:&h range:(length == 12 ? NSMakeRange(18, 4) : NSMakeRange(18, 2))];

        CGSize size = CGSizeMake(w, h);
        NSLog(@"bmp -- CGSize = %@", NSStringFromCGSize(size));
        return size;
    }
    
    if ([type isEqualToString:@"png"]) {
        
        CGFloat w = 0;
        CGFloat h = 0;
        [data getBytes:&w range:NSMakeRange(16, 4)];
        [data getBytes:&h range:NSMakeRange(20, 4)];
        
        CGSize size = CGSizeMake(w, h);
        NSLog(@"png -- CGSize = %@", NSStringFromCGSize(size));
        return size;
    }
    
    if ([type isEqualToString:@"gif"]) {
        
        CGFloat w = 0;
        CGFloat h = 0;
        [data getBytes:&w range:NSMakeRange(6, 2)];
        [data getBytes:&h range:NSMakeRange(8, 2)];
        
        CGSize size = CGSizeMake(w, h);
        NSLog(@"gif -- CGSize = %@", NSStringFromCGSize(size));
        return size;
        
    }
    if ([type isEqualToString:@"jpeg"]) {
        
        int i = 0;
        
        // 检测 jpeg  是不是 文件交换类型（SOI）
        if (bytes[i] == 0xFF && bytes[i+1] == 0xD8 && bytes[i+2] == 0xFF && bytes[i+3] == 0xE0) {
            
        }
        
        i += 4;
        
        return CGSizeMake(0, 0);
    }
    
    return CGSizeMake(0, 0);

}


@end
