//
//  AppDelegate+BackgroundTask.h
//  TAMall
//
//  Created by ws on 2017/5/10.
//  Copyright © 2017年 T.Ark. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BackgroundTask)


/**
    开启后台任务，在app切换至后台时预留时间搞事情
 */
- (void) beginBackgroundTaskWithBlock:(void (^)())doSomething;

/**
    关闭后台任务
 */
- (void) endBackgroundTask;
@end
