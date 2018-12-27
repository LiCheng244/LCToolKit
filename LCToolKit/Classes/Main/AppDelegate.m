//
//  AppDelegate.m
//  LCToolKit
//
//  Created by LiCheng on 2017/12/7.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import "AppDelegate.h"
#import "LCLaunchMovieVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import "LCTabBarController.h"
#include <objc/runtime.h>
#import "LCImgSizeManager.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


//    [NSThread sleepForTimeInterval:1.0f];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // 播放视频
//    LCLaunchMovieVC *videoVC = [[LCLaunchMovieVC alloc] init];
    LCTabBarController *tab = [[LCTabBarController alloc] init];
    self.window.rootViewController = tab;
    [self.window makeKeyAndVisible];

    
    /// 10以下
    
    Class lsawsc = objc_getClass("LSApplicationWorkspace");
    NSLog(@"lsawsc == %@", lsawsc);
    NSObject *workspace = [lsawsc performSelector:NSSelectorFromString(@"defaultWorkspace")];
    NSArray *apps = [workspace performSelector:NSSelectorFromString(@"allInstalledApplications")];
    NSLog(@"apps == %@", apps);

    NSURL *url = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/6d81800a19d8bc3ed69473cb848ba61ea8d34516.jpg"];
    LCImgSizeManager *manager = [[LCImgSizeManager alloc] init];
    [manager getSizeWithImgUrl:url force:NO succ:^(id response) {
        
    } fail:^(NSString *eInfo) {
        
    }];
    
    
    NSString *str = [self wifiSSID];
    
    NSLog(@"wifiSSID =  %@", str);
//
//    Class LSApplicationProxy_class = objc_getClass("LSApplicationProxy");
//    for (int i = 0; i < apps.count; i++) {
//        NSObject *temp = apps[i];
//        if ([temp isKindOfClass:LSApplicationProxy_class]) {
//            //应用的bundleId
//            NSString *appBundleId = [temp performSelector:NSSelectorFromString(@"applicationIdentifier")];
//            //应用的名称
//            NSString *appName = [temp performSelector:NSSelectorFromString(@"localizedName")];
//            //应用的类型是系统的应用还是第三方的应用
//            NSString * type = [temp performSelector:NSSelectorFromString(@"applicationType")];
//            //应用的版本
//            NSString * shortVersionString = [temp performSelector:NSSelectorFromString(@"shortVersionString")];
//
//            NSString * resourcesDirectoryURL = [temp performSelector:NSSelectorFromString(@"containerURL")];
//
//            NSLog(@"类型=%@应用的BundleId=%@ ++++应用的名称=%@版本号=%@\n%@",type,appBundleId,appName,shortVersionString,resourcesDirectoryURL);
//
//        }
//    }

    
//    //iOS 11 判断APP是否安装
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0) {
//        NSBundle *container = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/MobileContainerManager.framework"];
//        if ([container load]) {
//            Class appContainer = NSClassFromString(@"MCMAppContainer");
//
//            id test = [appContainer performSelector:@selector(containerWithIdentifier:error:) withObject:bundleId withObject:nil];
//            NSLog(@"%@",test);
//            if (test) {
//                return YES;
//            } else {
//                return NO;
//            }
//        }
//        return NO;
//
//    } else {
//        //非iOS11通过获取安装列表判断即可
//    }

    return YES;
}


- (NSString *)wifiSSID {
    
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    return ssid;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            if (@available(iOS 10.0, *)) {
                _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"LCToolKit"];
            } else {
                // Fallback on earlier versions
            }
            if (@available(iOS 10.0, *)) {
                [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                    if (error != nil) {
                        // Replace this implementation with code to handle the error appropriately.
                        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                        /*
                         Typical reasons for an error here include:
                         * The parent directory does not exist, cannot be created, or disallows writing.
                         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                         * The device is out of space.
                         * The store could not be migrated to the current model version.
                         Check the error message to determine what the actual problem was.
                         */
                        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                        abort();
                    }
                }];
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
