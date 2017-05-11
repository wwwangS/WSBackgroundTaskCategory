//
//  AppDelegate.m
//  WSBackgroundTaskCategory
//
//  Created by ws on 2017/5/10.
//  Copyright © 2017年 ws. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+BackgroundTask.h"


@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // beginBackgroundTask
    [self beginBackgroundTaskWithBlock:^{
        NSLog(@"处理一些数据");
    }];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // beginBackgroundTask
    [self endBackgroundTask];
}


@end
