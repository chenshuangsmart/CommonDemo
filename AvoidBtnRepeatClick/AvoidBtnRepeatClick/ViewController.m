//
//  ViewController.m
//  AvoidBtnRepeatClick
//
//  Created by chenshuang on 2019/6/12.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self drawBtn];
}

- (void)drawBtn {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [btn setTitle:@"按钮点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    // 按钮不可点击时,文字颜色置灰
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)tapBtn:(UIButton *)btn {
    NSLog(@"按钮点击...");
    btn.enabled = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
}

@end
