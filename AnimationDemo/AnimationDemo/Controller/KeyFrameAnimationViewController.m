//
//  KeyFrameAnimationViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/13.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "KeyFrameAnimationViewController.h"

@interface KeyFrameAnimationViewController ()
@property (nonatomic, strong) CALayer *layer;
@end

@implementation KeyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关键帧动画";
    //设置背景（注意这个图片其实在根图层）
    UIImage* backgroundImage = [UIImage imageNamed:@"snow"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    self.layer = [[CALayer alloc]init];
    self.layer.bounds= CGRectMake(0, 0, 25, 25);
    self.layer.position = CGPointMake(self.view.width * 0.5, 150);
    self.layer.contents = (id)[UIImage imageNamed:@"snowflake"].CGImage;
    [self.view.layer addSublayer:self.layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //创建动画
//    [self translationAnimation_values];
    
    // 贝尔曲线动画
    [self translationAnimation_path];
}

- (void)translationAnimation_values {
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation* keyFrameAnimation =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置关键帧，这里有四个关键帧
    NSValue* key1 = [NSValue valueWithCGPoint:self.layer.position];//对于关键帧动画初始值不能省略
    NSValue* key2 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue* key3 = [NSValue valueWithCGPoint:CGPointMake(45, 320)];
    NSValue* key4 = [NSValue valueWithCGPoint:CGPointMake(75, 420)];
    //设置其他属性
    keyFrameAnimation.values = @[key1,key2,key3,key4];
    keyFrameAnimation.duration = 7;
    //keyFrameAnimation.beginTime = CACurrentMediaTime() + 2;//设置延迟2秒执行
    keyFrameAnimation.keyTimes = @[@(2/7.0),@(5.5/7),@(6.25/7),@1.0];
    
    //3.添加动画到图层，添加动画后就会行动画
    [self.layer addAnimation:keyFrameAnimation forKey:@"myAnimation"];
}

- (void)translationAnimation_path {
    
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation* keyFrameAnimation =[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置路径
    //贝塞尔曲线
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.layer.position.x, self.layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
    keyFrameAnimation.path = path;
    CGPathRelease(path);
    
    keyFrameAnimation.duration = 5.0;
//    keyFrameAnimation.beginTime = CACurrentMediaTime() + 2;//设置延迟2秒执行
    
    //3.添加动画到图层，添加动画后就会行动画
    [self.layer addAnimation:keyFrameAnimation forKey:@"myAnimation"];
}

@end
