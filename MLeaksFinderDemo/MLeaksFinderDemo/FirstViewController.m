//
//  FirstViewController.m
//  MLeaksFinderDemo
//
//  Created by chenshuang on 2019/4/6.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
/** timer*/
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTimer];
    [self drawUI];
}

- (void)drawUI {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapBackBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

- (void)tapBackBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addTimer {
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer {
    NSLog(@"%s",__func__);
}


@end
