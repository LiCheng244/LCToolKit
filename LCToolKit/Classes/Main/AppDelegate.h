//
//  AppDelegate.h
//  LCToolKit
//
//  Created by LiCheng on 2017/12/7.
//  Copyright © 2017年 LiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

