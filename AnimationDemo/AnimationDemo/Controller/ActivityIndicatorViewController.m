//
//  ActivityIndicatorViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/7.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "ActivityIndicatorViewController.h"
#import "ActivityIndicatorView.h"
#import "UIView+Extension.h"

static  const CFTimeInterval duration = 3.0;

@interface ActivityIndicatorViewController ()
/** gray */
@property(nonatomic,strong)UIImageView *grayHeadImgView;
/** green */
@property(nonatomic,strong)UIImageView *greenHeadImgView;
@property (nonatomic, strong) CAShapeLayer *maskLayerUp;
@property (nonatomic, strong) CAShapeLayer *maskLayerDown;
/** activity */
@property(nonatomic,strong)ActivityIndicatorView *loadingIndicator;
@end

@implementation ActivityIndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawUI];
    
    self.greenHeadImgView.layer.mask = [self greenHeadMaskLayer];
}

- (void)drawUI {
    CGFloat imgWH = 60;
    
    UIButton *btn1 = [self addBtnWithTitle:@"注水" action:@selector(startGreenHeadAnimation)];
    btn1.centerX = self.view.width * 0.5;
    btn1.y = 100;
    
    UIButton *btn2 = [self addBtnWithTitle:@"loading" action:@selector(startLoading)];
    btn2.centerX = self.view.width * 0.5;
    btn2.y = btn1.bottom + 10;;
    
    self.grayHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWH, imgWH)];
    self.grayHeadImgView.image = [UIImage imageNamed:@"bull_head_gray"];
    self.grayHeadImgView.center = self.view.center;
    [self.view addSubview:self.grayHeadImgView];
    
    self.greenHeadImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWH, imgWH)];
    self.greenHeadImgView.image = [UIImage imageNamed:@"bull_head_green"];
    self.greenHeadImgView.center = self.view.center;
    [self.view addSubview:self.greenHeadImgView];
    
    self.loadingIndicator.centerX = self.view.width * 0.5;
    self.loadingIndicator.y = self.view.height * 0.7;
    [self.view addSubview:self.loadingIndicator];
}

- (UIButton *)addBtnWithTitle:(NSString *)title action:(SEL)action {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 25)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

#pragma mark - action

- (void)startLoading {
    [self.loadingIndicator startAnimation];
}

- (CALayer*)greenHeadMaskLayer {
    CALayer* mask = [CALayer layer];
    mask.frame = self.greenHeadImgView.bounds;
    
    self.maskLayerUp = [CAShapeLayer layer];
    self.maskLayerUp.bounds = CGRectMake(0, 0, 60.0f, 60.f);
    self.maskLayerUp.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30.0, 30.0) radius:30.0f startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    
    self.maskLayerUp.opacity = 0.8f;
    self.maskLayerUp.position = CGPointMake(-5.0f, -5.0f);
    [mask addSublayer:self.maskLayerUp];
    
    self.maskLayerDown = [CAShapeLayer layer];
    self.maskLayerDown.bounds = CGRectMake(0, 0, 60.f,60.f);
    self.maskLayerDown.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerDown.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(30.0, 30.0) radius:30.0 startAngle:0 endAngle:2*M_PI clockwise:YES].CGPath;
    self.maskLayerDown.position = CGPointMake(65.f, 65.f);
    [mask addSublayer:self.maskLayerDown];
    
    return mask;
}

- (void)startGreenHeadAnimation {
    CABasicAnimation* animationDown = [CABasicAnimation animationWithKeyPath:@"position"];
    animationDown.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5.0f, -5.0f)];
    animationDown.toValue = [NSValue valueWithCGPoint:CGPointMake(25.0f, 25.0f)];
    animationDown.duration = duration;
    animationDown.repeatCount = MAXFLOAT;
    [self.maskLayerUp addAnimation:animationDown forKey:@"downAnimation"];
    
    CABasicAnimation* animationUp = [CABasicAnimation animationWithKeyPath:@"position"];
    animationUp.fromValue = [NSValue valueWithCGPoint:CGPointMake(65.f, 65.f)];
    animationUp.toValue = [NSValue valueWithCGPoint:CGPointMake(35.f, 35.f)];
    animationUp.duration = duration;
    animationUp.repeatCount = MAXFLOAT;
    [self.maskLayerDown addAnimation:animationUp forKey:@"upAnimation"];
}

#pragma mark - lazy

- (ActivityIndicatorView *)loadingIndicator {
    if (_loadingIndicator == nil) {
        _loadingIndicator = [[ActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _loadingIndicator;
}

@end
