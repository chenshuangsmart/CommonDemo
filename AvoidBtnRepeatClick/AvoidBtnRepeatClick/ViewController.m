//
//  ViewController.m
//  AvoidBtnRepeatClick
//
//  Created by chenshuang on 2019/6/12.
//  Copyright © 2019年 wenwen. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Extension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self drawBtn];
    
    // 方法三交换
//    [self drawExpecialBtn];
    
    // UISlide 奔溃
    [self slideTest];
}

- (void)drawBtn {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [btn setTitle:@"按钮点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    // 按钮不可点击时,文字颜色置灰
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

/** 方法一 */
//- (void)tapBtn:(UIButton *)btn {
//    NSLog(@"按钮点击...");
//    btn.enabled = NO;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        btn.enabled = YES;
//    });
//}

/** 方法二 */
//- (void)tapBtn:(UIButton *)btn {
//    NSLog(@"按钮点击了...");
//    // 此方法会在连续点击按钮时取消之前的点击事件，从而只执行最后一次点击事件
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(buttonClickedAction:) object:btn];
//    // 多长时间后做某件事情
//    [self performSelector:@selector(buttonClickedAction:) withObject:btn afterDelay:2.0];
//}
//
//- (void)buttonClickedAction:(UIButton *)btn {
//    NSLog(@"真正开始执行业务 - 比如网络请求...");
//}

/** 方法三 */
- (void)drawExpecialBtn{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [btn setTitle:@"按钮点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    // 按钮不可点击时,文字颜色置灰
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.cs_eventInterval = 2.0;
    [self.view addSubview:btn];
}

- (void)tapBtn:(UIButton *)btn {
    NSLog(@"按钮点击...");
}

/** 注意事项 */
- (void)slideTest {
    UISlider *slide = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 200, 59)];
    [slide addTarget:self action:@selector(tapSlide:) forControlEvents:UIControlEventTouchUpInside];
    slide.center = self.view.center;
    [self.view addSubview:slide];
}

- (void)tapSlide:(UISlider *)slider {
    NSLog(@"UISlider点击...");
}

@end
