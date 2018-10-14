//
//  CoreAnimationViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/8.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()<CAAnimationDelegate>

@end

@implementation CoreAnimationViewController {
    CALayer *_layer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基础动画";
    [self addSubLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self addAnimation];
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    [self translatonAnimation:point];
    
    [self rotationAnimation];
}

- (void)addSubLayer {
    //设置背景(注意这个图片其实在根图层)
//    UIImage *backgroundImage = [UIImage imageNamed:@"women"];
//    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    
    // 自定义一个图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 35, 35);
    _layer.position=CGPointMake(50, 150);
    _layer.contents=(id)[UIImage imageNamed:@"snowflake"].CGImage;
    [self.view.layer addSublayer:_layer];
}

- (void)addAnimation {
    UIImage *image=[UIImage imageNamed:@"girl"];
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=image;
    imageView.frame=CGRectMake(120, 140, 80, 80);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    //两秒后开始一个持续一分钟的动画
    [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        imageView.frame=CGRectMake(80, 100, 160, 160);
    } completion:nil];
}

#pragma mark 移动动画

-(void)translatonAnimation:(CGPoint)location{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
         
    //2.设置动画属性初始值和结束值
    //basicAnimation.fromValue=[NSNumber numberWithInteger:50];//可以不设置，默认为图层初始状态
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
         
    //设置其他动画属性
    basicAnimation.duration = 2.0;//动画时间5秒
    // basicAnimation.repeatCount=HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
    basicAnimation.removedOnCompletion = NO;//运行一次是否移除动画
    
    basicAnimation.delegate = self;
    //存储当前位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
         
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}

#pragma mark 旋转动画
- (void)rotationAnimation{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
      
    //2.设置动画属性初始值、结束值
    // basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI_2 * 3];
     
    //设置其他动画属性
    basicAnimation.duration = 2.0;
    basicAnimation.autoreverses = true;//旋转后再旋转到原来的位置
    
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}

#pragma mark - 动画代理方法
// 动画开始
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前面的设置的key获得动画
}

// 动画结束
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    // 如果直接设置值,会出现直接从起点跳转到终点
//    _layer.position = [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    //开启事务
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];

    _layer.position=[[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];

    //提交事务
    [CATransaction commit];
}


@end
