//
//  AnimationFromUIViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/14.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "AnimationFromUIViewController.h"

@interface AnimationFromUIViewController ()

@end

@implementation AnimationFromUIViewController {
    UIImageView* _imageView;
    UIImageView* _ball;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建图像显示空间
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"snow"]];
    _imageView.center = CGPointMake(50, 150);
    [self.view addSubview:_imageView];
    
    _ball = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"snowflake"]];
    _ball.center = self.view.center;
    [self.view addSubview:_ball];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    [self startBasicAnimate:location];
    
    [self startSpringAnimate:location];
}

- (void)startSpringAnimate:(CGPoint)location {
    //创建阻尼动画
    //damping:阻尼,范围0-1，阻尼越接近于0，弹性效果越明显
    //velocity:弹性复位的速度
    [UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _ball.center = location;
    } completion:nil];
}

- (void)startBasicAnimate:(CGPoint)location {
    //方法1；block方法
    /*
     开始动画，UIView的动画方法执行完后动画会停留在重点位置，而不需要进行任何特殊处理
     duration：执行时间
     delay：延迟时间
     option:动画设置，列如自动恢复，匀速运动等
     completion:动画完成回调方法
     */
    
    //    [UIView animateWithDuration:1.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
    //        _imageView.center = location;
    //    } completion:^(BOOL finished) {
    //        NSLog(@"animate is end");
    //    }];
    
    //方法2:静态方法
    //开始动画
    [UIView beginAnimations:@"ZXBasicAnimation" context:nil];
    [UIView setAnimationDuration:1.5];
    //[UIView setAnimationDelay:1.0];//设置延迟
    //[UIView setAnimationRepeatAutoreverses:NO];//是否回复
    //[UIView setAnimationRepeatCount:10];//重复次数
    //[UIView setAnimationStartDate:(NSDate *)];//设置动画开始运行的时间
    //[UIView setAnimationDelegate:self];//设置代理
    //[UIView setAnimationWillStartSelector:(SEL)];//设置动画开始运动的执行方法
    //[UIView setAnimationDidStopSelector:(SEL)];//设置动画运行结束后的执行方法
    
    _imageView.center = location;
    
    //开始动画
    [UIView commitAnimations];
    
}

@end
