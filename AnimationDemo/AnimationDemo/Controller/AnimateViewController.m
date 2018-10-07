//
//  AnimateViewController.m
//  AnimationDemo
//
//  Created by cs on 2018/10/6.
//  Copyright © 2018 cs. All rights reserved.
//

#import "AnimateViewController.h"
#import "UIView+Extension.h"
#import "MyTestView.h"

@interface AnimateViewController ()
/** redView */
@property(nonatomic, strong)MyTestView *redView;
@end

@implementation AnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"UIView动画";
    
    [self drawUI];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test];
}

- (void)drawUI {
    CGFloat screamH = [[UIScreen mainScreen] bounds].size.height;
    
    UIButton *btn1 = [self addBtnWithTitle:@"直接改变大小" action:@selector(directChangeSize)];
    btn1.x = 20;
    btn1.y = 100;
    
    UIButton *btn2 = [self addBtnWithTitle:@"动画改变大小" action:@selector(animateChangeSize)];
    btn2.x = self.view.width - btn2.width - 20;;
    btn2.y = btn1.y;
    
    UIButton *btn3 = [self addBtnWithTitle:@"UIView动画3S" action:@selector(animateThreeSecond)];
    btn3.x = btn1.x;
    btn3.y = screamH - 100;
    
    UIButton *btn4 = [self addBtnWithTitle:@"UIView动画1S" action:@selector(animateOneSecond)];
    btn4.x = btn2.x;
    btn4.y = btn3.y;
    
    MyTestView *redView = [[MyTestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.redView = redView;
    redView.backgroundColor = [UIColor redColor];
    redView.center = self.view.center;
    [self.view addSubview:redView];
}

// 直接改变大小
- (void)directChangeSize {
    if (self.redView.width > 150) {
        self.redView.bounds = CGRectMake(0, 0, 100, 100);
    } else {
        self.redView.bounds = CGRectMake(0, 0, 200, 200);
    }
}

// 动画改变大小
- (void)animateChangeSize {
//    [UIView animateWithDuration:3.0 animations:^(void){
//        if (self.redView.width > 150) {
//            self.redView.bounds = CGRectMake(0, 0, 100, 100);
//        } else {
//            self.redView.bounds = CGRectMake(0, 0, 200, 200);
//        }
//    } completion:^(BOOL finished){
//        NSLog(@"%d",finished);
//    }];
    
    self.redView.bounds = CGRectMake(0, 0, 100, 100);
    [UIView animateWithDuration:1.0 animations:^{
        self.redView.bounds = CGRectMake(0, 0, 200, 200);
    } completion:^(BOOL finished) {
        NSLog(@"finished = %d",finished);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"layer:%@",self.redView.layer);
        NSLog(@"layer.presentationLayer:%@",self.redView.layer.presentationLayer);
        NSLog(@"layer.modelLayer:%@",self.redView.layer.modelLayer);
        NSLog(@"layer.presentationLayer.modelLayer:%@",self.redView.layer.presentationLayer.modelLayer);
    });
}

// 动画时间3秒
- (void)animateThreeSecond {
    NSLog(@"3S动画开始");
    [UIView animateWithDuration:3.0 animations:^(void){
        if (self.redView.width > 150) {
            self.redView.bounds = CGRectMake(0, 0, 100, 100);
        } else {
            self.redView.bounds = CGRectMake(0, 0, 200, 200);
        }
    } completion:^(BOOL finished){
        NSLog(@"3秒动画结束 %d",finished);
    }];
}

// 动画时间1秒
- (void)animateOneSecond {
    NSLog(@"1S动画开始");
    [UIView animateWithDuration:1.0 animations:^(void){
        if (self.redView.width > 150) {
            self.redView.bounds = CGRectMake(0, 0, 100, 100);
        } else {
            self.redView.bounds = CGRectMake(0, 0, 200, 200);
        }
    } completion:^(BOOL finished){
        NSLog(@"1S动画结束 %d",finished);
    }];
}

- (void)test {
    MyTestView *view = [[MyTestView alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    [self.view addSubview:view];
    
    view.center = CGPointMake(1000, 1000);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((1/60) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"presentationLayer %@ y %f",view.layer.presentationLayer, view.layer.presentationLayer.position.y);
        NSLog(@"layer.modelLayer %@ y %f",view.layer.modelLayer,view.layer.modelLayer.position.y);
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((1/10) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"presentationLayer %@ y %f",view.layer.presentationLayer, view.layer.presentationLayer.position.y);
        NSLog(@"layer.modelLayer %@ y %f",view.layer.modelLayer,view.layer.modelLayer.position.y);
    });
}

- (UIButton *)addBtnWithTitle:(NSString *)title action:(SEL)action {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 125, 25)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

@end
