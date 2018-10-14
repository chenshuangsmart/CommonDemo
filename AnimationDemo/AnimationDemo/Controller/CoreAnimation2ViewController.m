//
//  CoreAnimationViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/8.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "CoreAnimation2ViewController.h"

@interface CoreAnimation2ViewController ()<CAAnimationDelegate>

@end

@implementation CoreAnimation2ViewController {
    CALayer *_layer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基础动画2";
    [self addSubLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint position = [touch locationInView:self.view];
    
    CAAnimation *animation = [_layer animationForKey:@"ZXBasicAnimation_rotation"];
    //创建并开始动画
    if (animation) {
        if (_layer.speed == 0) {
            [self animationResume];
        }else{
            [self animationPause];
        }
    } else {
        [self translatonAnimation:position];
        [self rotationAnimation];
    }
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

#pragma mark - 暂停 | 继续

- (void)animationPause {
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval = [_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //设置时间偏移量，保证暂停时停留在旋转的位置
    _layer.timeOffset = interval;
    //速度设置为零，暂停动画
    _layer.speed = 0;
}

- (void)animationResume {
    //获取暂停的时间
    CFTimeInterval beginTime = CACurrentMediaTime() - _layer.timeOffset;
    //设置偏移量
    _layer.timeOffset = 0;
    //设置开始时间
    _layer.beginTime = beginTime;
    //设置动画速度，开始运动
    _layer.speed = 1.0;
}

#pragma mark 移动动画 | 旋转动画

-(void)translatonAnimation:(CGPoint)location{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    //2.设置动画属性初始值和结束值
    //basicAnimation.fromValue=[NSNumber numberWithInteger:50];//可以不设置，默认为图层初始状态
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    
    //设置其他动画属性
    basicAnimation.duration = 1.0;//动画时间5秒
    
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    basicAnimation.removedOnCompletion = NO;
    
    basicAnimation.delegate = self;
    //存储当前位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}

-(void)rotationAnimation{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    
    //2.设置动画属性初始值、结束值
    // basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    
    //设置其他动画属性
    basicAnimation.duration = 1.0;
    basicAnimation.autoreverses = true;//旋转后再旋转到原来的位置
    basicAnimation.repeatCount = HUGE_VAL;
    basicAnimation.removedOnCompletion = NO;

    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}

#pragma mark - 动画代理方法
// 动画开始
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前面的设置的key获得动画
}

// 动画结束
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
//    _layer.position = [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    

    /* 代码运行到此处会发现另一问题：
     问题产生的原因是：
     对于非根图层，设置图层的可动画属性（在动画结束后重新设置了position，而position是可动画属性）会产生动画效果。
     解决这个问题有两种办法：
     关闭图层隐式动画、设置动画图层为根图层。显然这里不能采取后者，因为根图层当前已经作为动画的背景。
     */
    
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    // 要关闭隐式动画需要用到动画事务CATransaction，在事务内讲隐式动画关闭
    // 开启事务
    [CATransaction begin];
    // 禁用隐式动画
    [CATransaction setDisableActions:YES];
    
    _layer.position = [[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    
    //提交事务
    [CATransaction commit];
    
    //暂停旋转动画
    [self animationPause];
}

@end
