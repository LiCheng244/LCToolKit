//
//  ImgSizeManager.m
//  LCToolKit
//
//  Created by LiCheng on 2018/12/17.
//  Copyright © 2018年 LiCheng. All rights reserved.
//

#import "LCImgSizeManager.h"
#import "LCImgSizeParser.h"


@interface LCImgSizeManager ()<NSURLSessionDelegate>

/// 用来下载数据
@property (nonatomic, strong) NSURLSession *session;

/// 队列操作
@property (nonatomic, strong) NSOperationQueue *queue;

/// 内置缓存
@property (nonatomic, strong) NSCache<NSURL *, LCImgSizeParser *> *cache;

/// 请求超时时间
@property (nonatomic, assign) NSTimeInterval timeout;


@end


@implementation LCImgSizeManager



- (void)getSizeWithImgUrl:(NSURL *)url force:(BOOL)force succ:(SuccBlock)succ fail:(FailBlock)fail {
    
    self.timeout = 5;
    self.session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration delegate:self delegateQueue:nil];
    
    if (force) { // 获取缓存数据
        
        
    } else { // 网络获取
        
        NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:self.timeout];
        [self.session dataTaskWithRequest:req];


        NSLog(@"NSURLRequest = %@", req);
    
        
    }
}


#pragma mark - ------ NSURLSessionDelegate ------

/// 数据改变时
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    NSLog(@"session = %@", session);
    NSLog(@"challenge = %@", challenge);
    
}

/// 加载失败时
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    
    NSLog(@"error = %@", error);

}

@end
