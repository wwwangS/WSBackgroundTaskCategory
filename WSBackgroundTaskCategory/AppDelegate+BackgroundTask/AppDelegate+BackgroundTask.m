//
//  AppDelegate+BackgroundTask.m
//  TAMall
//
//  Created by ws on 2017/5/10.
//  Copyright © 2017年 T.Ark. All rights reserved.
//

#import "AppDelegate+BackgroundTask.h"
#import <objc/runtime.h>



@interface AppDelegate ()

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic, strong) NSTimer *backgroundTimer;

@end

static const void * timerKey;

@implementation AppDelegate (BackgroundTask)


-(void)beginBackgroundTaskWithBlock:(void (^)())doSomething{
    if ([self isMultitaskingSupported] == NO) {
        return;
    }
    
    self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(void){
        //  end time
        [self endBackgroundTask];
    }];
    
    doSomething();
    self.backgroundTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                            target:self
                                                          selector:@selector(timerMethod:)     userInfo:nil
                                                           repeats:YES];
}

- (void) endBackgroundTask{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    AppDelegate *weakSelf = self;
    dispatch_async(mainQueue, ^(void) {
        
        if (weakSelf != nil){
            [weakSelf.backgroundTimer invalidate];
            weakSelf.backgroundTimer = nil;
        
            //  end task
            [[UIApplication sharedApplication] endBackgroundTask:weakSelf.backgroundTaskIdentifier];
            weakSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        }
    });
}

- (void) timerMethod:(NSTimer *)paramSender{
    NSTimeInterval backgroundTimeRemaining =[[UIApplication sharedApplication] backgroundTimeRemaining];
    if (backgroundTimeRemaining == DBL_MAX){
        NSLog(@"Background Time Remaining = Undetermined");
    } else {
        NSLog(@"Background Time Remaining = %.02f Seconds", backgroundTimeRemaining);
    }
}




/**
    检测是否支持多任务
 */
- (BOOL) isMultitaskingSupported{
    return [[UIDevice currentDevice] isMultitaskingSupported];
}


#pragma mark -


-(UIBackgroundTaskIdentifier)backgroundTaskIdentifier{
    UIBackgroundTaskIdentifier backgroundTaskIdentifier = (UIBackgroundTaskIdentifier ) objc_getAssociatedObject(self, _cmd);
    return backgroundTaskIdentifier;
}

-(void)setBackgroundTaskIdentifier:(UIBackgroundTaskIdentifier)backgroundTaskIdentifier{
    objc_setAssociatedObject(self, _cmd, @(backgroundTaskIdentifier), OBJC_ASSOCIATION_ASSIGN);
}

-(NSTimer *)backgroundTimer{
    NSTimer * backgroundTimer = objc_getAssociatedObject(self,timerKey);
    return backgroundTimer;
}

-(void)setBackgroundTimer:(NSTimer *)backgroundTimer{
    objc_setAssociatedObject(self, timerKey, backgroundTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
