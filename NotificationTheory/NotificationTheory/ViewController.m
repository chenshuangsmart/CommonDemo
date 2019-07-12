//
//  ViewController.m
//  NotificationTheory
//
//  Created by cs on 2019/7/8.
//  Copyright © 2019 cs. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CSNotificationCenter.h"

static NSString *kTextFieldValueChange = @"kTextFieldValueChange";

@interface ViewController ()
/** lbe */
@property(nonatomic, weak)UILabel *lbe;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawUI];
    
    // add observer
    [self addObserver];
}

#pragma mark - drawUI

- (void)drawUI {
    UILabel *lbe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    lbe.textColor = [UIColor blackColor];
    lbe.center = self.view.center;
    lbe.layer.borderWidth = 1;
    lbe.layer.borderColor = [[UIColor grayColor] CGColor];
    [self.view addSubview:self.lbe = lbe];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapJump) forControlEvents:UIControlEventTouchUpInside];
    btn.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.7);
    [self.view addSubview:btn];
}

#pragma mark - action

- (void)tapJump {
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - observer

- (void)addObserver {
    // 1.使用系统方法添加观察者 - 观察者接收到通知后执行任务的代码在发送通知的线程中执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:kTextFieldValueChange object:nil];
    
    // 2.使用系统方法添加观察者 - 队列回调 - 观察者接收到通知后执行任务的代码在指定的操作队列中执行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [[NSNotificationCenter defaultCenter] addObserverForName:kTextFieldValueChange object:nil queue:queue usingBlock:^(NSNotification *note) {
        // 异步回调主线程,与主线程通信
        dispatch_async(dispatch_get_main_queue(), ^{
            [self change:note];
        });
    }];
    
    // 3.添加自定义观察者
    [[CSNotificationCenter defaultCenter] addObserver:self selector:@selector(customChange:) name:kTextFieldValueChange object:nil];
    
    // 4.添加自定义观察者 - 队列回调
    [[CSNotificationCenter defaultCenter] addObserverForName:kTextFieldValueChange object:nil queue:queue usingBlock:^(CSNotification *note) {
        // 异步回调主线程,与主线程通信
        dispatch_async(dispatch_get_main_queue(), ^{
            [self customChange:note];
        });
    }];
}

- (void)change:(NSNotification *)notification {
    NSString *text = (NSString *)notification.object;
    [self.lbe setText:text];
    
    NSLog(@"当前线程是否是主线程: %d",[NSThread isMainThread]);
}

- (void)customChange:(CSNotification *)notification {
    NSString *text = (NSString *)notification.object;
    [self.lbe setText:text];
    
    NSLog(@"当前线程是否是主线程: %d",[NSThread isMainThread]);
}

#pragma mark - dealloc

- (void)dealloc {
    // remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kTextFieldValueChange object:nil];
    [[CSNotificationCenter defaultCenter] removeObserver:self name:kTextFieldValueChange object:nil];
}

@end
