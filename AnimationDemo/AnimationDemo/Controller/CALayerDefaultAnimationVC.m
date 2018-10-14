//
//  CALayerDefaultAnimationVC.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/8.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "CALayerDefaultAnimationVC.h"

#define kWidth 50.0

@interface CALayerDefaultAnimationVC ()
@property (nonatomic, strong) CALayer *thisLayer;
@end

@implementation CALayerDefaultAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CALayer隐式动画";
    [self drawMyLayer];
}

#pragma mark - 绘制图层

- (void)drawMyLayer {
    CGSize size = [UIScreen mainScreen].bounds.size;
    //获取根图层
    CALayer* layer = [[CALayer alloc]init];
    //设置背景颜色，由于QuartzCore是跨平台框架，无法直接使用UIColor
    layer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    //设置中心点
    layer.position = CGPointMake(size.width/2, size.height/2 );
    //设置大小
    layer.bounds = CGRectMake(0, 0, kWidth, kWidth);
    //设置圆角，当圆角半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius = kWidth/2;
    //设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9f;
    //设置锚点
    //layer.anchorPoint =  CGPointMake(0, 0);
    //layer.anchorPoint = CGPointMake(1, 1);
    [self.view.layer addSublayer:layer];
    self.thisLayer = layer;
}

#pragma mark - 点击放大

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:self.view];
    CALayer* layer = [self.view.layer.sublayers lastObject];
    CGFloat width = layer.bounds.size.width;
    
    if (width == kWidth) {
        width = 4 * kWidth;
        layer.backgroundColor = [UIColor colorWithRed:1. green:0.1 blue:0.7 alpha:1.0].CGColor;
    } else {
        width = kWidth;
        layer.backgroundColor = [UIColor colorWithRed:0 green:146/255. blue:1.0 alpha:1.0].CGColor;
    }
    
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, width, width);
    NSLog(@"point:%@",NSStringFromCGPoint(position));
}

@end
