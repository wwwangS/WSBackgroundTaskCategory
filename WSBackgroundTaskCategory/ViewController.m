//
//  ViewController.m
//  WSBackgroundTaskCategory
//
//  Created by ws on 2017/5/10.
//  Copyright © 2017年 ws. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSTimer * _timer;
    NSInteger _date;
    
    UILabel * _textLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _date = 300;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
    _textLabel = [[UILabel alloc]initWithFrame:self.view.frame];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textLabel];
}

-(void)timerFireMethod:(NSTimer *)timer {
    _date --;
    if (_date == 0) {
        [_timer invalidate];
    }

    _textLabel.text = [NSString stringWithFormat:@"%ldS", _date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
