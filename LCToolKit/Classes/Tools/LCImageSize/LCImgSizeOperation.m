//
//  LCImgSizeOperation.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/17.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCImgSizeOperation.h"

@interface LCImgSizeOperation ()

@property (nonatomic, assign) BOOL isCancelled;
@property (nonatomic, strong) NSURLSessionDataTask *request;
@property (nonatomic, strong) NSData *receivedData;
@end

@implementation LCImgSizeOperation


- (void)main {
  
    if (self.isCancelled) {
        return;
    }
    
    NSURL *downUrl = [NSURL URLWithString:self.urlStr];
    NSData *data = [NSData dataWithContentsOfURL:downUrl];
    
    
}

- (void)start {
  
    if (self.isCancelled) {
        return;
    }
    
    [self.request resume];
}

- (void)cancel {
    
    [self.request cancel];
    [super cancel];
}

- (void)onReceiveData:(NSData *)data {
    
    if (self.isCancelled) {
        return;
    }
    
    [self.receivedData initWithData:data];
//    [self.receivedData.append:data];
    
    if (data.length < 2) {
        NSLog(@"数据太少");
        return;
    }
    
    
}
@end
