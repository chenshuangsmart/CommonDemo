//
//  LayerTransformViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/7.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "LayerTransformViewController.h"
#import "UIView+Extension.h"

@interface LayerTransformViewController ()

@end

static CGFloat saveH = 350; // 安全距离

@implementation LayerTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawUI];
}

- (void)drawUI {
    // 仿射变换
    UIButton *btn1 = [self addBtnWithTitle:@"仿射变换" action:@selector(affineTransform)];
    btn1.centerX = self.view.width * 0.5;
    btn1.y = 100;
    [self.view addSubview:btn1];
    
    // 裁剪图片一部分
    UIButton *btn2 = [self addBtnWithTitle:@"裁剪图片一部分" action:@selector(maskView)];
    btn2.centerX = btn1.centerX;
    btn2.y = btn1.bottom + 10;
    [self.view addSubview:btn1];
    
    // 剪切超过父图层的部分
    UIButton *btn3 = [self addBtnWithTitle:@"剪切超过父图层的部分" action:@selector(masksToBounds)];
    btn3.centerX = btn1.centerX;
    btn3.y = btn2.bottom + 10;
    [self.view addSubview:btn3];
    
    // 阴影路径
    UIButton *btn4 = [self addBtnWithTitle:@"阴影路径" action:@selector(shadowPath)];
    btn4.centerX = btn1.centerX;
    btn4.y = btn3.bottom + 10;
    [self.view addSubview:btn4];
    
    // 添加阴影
    UIButton *btn5 = [self addBtnWithTitle:@"添加阴影" action:@selector(addShadowPath)];
    btn5.centerX = btn1.centerX;
    btn5.y = btn4.bottom + 10;
    [self.view addSubview:btn5];
    
    // 图层内容和内容模式
    UIButton *btn6 = [self addBtnWithTitle:@"图层内容和内容模式" action:@selector(addContentMode)];
    btn6.centerX = btn1.centerX;
    btn6.y = btn5.bottom + 10;
    [self.view addSubview:btn6];
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

// 仿射变换
- (void)affineTransform {
    CALayer* layer = [CALayer layer];
    layer.frame = CGRectMake(100, self.view.height - 200, 200, 50);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    //设置层内容
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"logo"].CGImage);
    //X轴旋转45°
    //layer.transform = CATransform3DMakeRotation(45*(M_PI)/180.0, 1, 0, 0);
    //旋转45° 度数 x y z
    //layer.transform = CATransform3DMakeRotation(90*(M_PI)/180.0, 1, 0, 0);
    
    //CATransform3DMakeRotation(<#CGFloat angle#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat z#>);3D旋转
    //CATransform3DTranslate(<#CATransform3D t#>, <#CGFloat tx#>, <#CGFloat ty#>, <#CGFloat tz#>);3D位移
    //CATransform3DMakeScale(<#CGFloat sx#>, <#CGFloat sy#>, <#CGFloat sz#>);3D缩放
    //CATransform3DMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>, <#CGFloat tz#>)
    
    //仿射变换
    layer.affineTransform = CGAffineTransformMakeRotation(45*(M_PI)/180);
}

// 剪切图片的一部分
- (void)maskView {
    int width = 80;
    int height = 100;
    int sapce = 3;
    
    for(int i = 0; i < 9; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(60 + (width + sapce) * (i%3), 80 + (height + sapce) * (i/3), width, height);
        view.backgroundColor = [UIColor redColor];
        //设置层的内容
        view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"women"].CGImage);
        //设置图片剪切的范围  [0,1]  contentsRect 图层显示内容的大小和位置
        view.layer.contentsRect = CGRectMake(1.0/3.0 * (i%3), 1.0/3.0 * (i/3), 1.0/3.0, 1.0/3.0);
        [self.view addSubview:view];
        /*
         1：（0，0，1/3,1/3）
         2: (1/3,0，1/3,1/3)
         3: (2/3,0，1/3,1/3)
         */
    }
}

// 图层添加边框和圆角
- (void)addRadiusAndBorder {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(60, 60, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    //边框颜色
    layer.borderColor = [UIColor greenColor].CGColor;
    //边框宽度
    layer.borderWidth = 3;
    //圆角
    layer.cornerRadius = 10;
}

// 剪切超过父图层的部分
- (void)masksToBounds {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(60, 60, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(30, 30, 100, 100);
    layer2.backgroundColor = [UIColor blueColor].CGColor;
    [layer addSublayer:layer2];
    //剪切超过父图层的部分
    layer.masksToBounds = YES;
}

// 阴影路径
- (void)shadowPath {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(60,saveH + 60, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    //1表明不透明，注意：设置阴影当前值不能为0，默认是0
    layer.shadowOpacity = 1.0;
    //阴影颜色
    layer.shadowColor = [UIColor yellowColor].CGColor;
    //创建路径
    CGMutablePathRef path = CGPathCreateMutable();
    //椭圆
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, 200, 200));
    layer.shadowPath = path;
    CGPathRelease(path);
}

#pragma mark - 添加阴影_02
- (void)addShadowPath {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(60, saveH + 60, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    layer.shadowOpacity = 0.9;
    layer.shadowColor = [UIColor yellowColor].CGColor;
    //阴影偏移 ->x正 ->-x负 ，y同理
    layer.shadowOffset = CGSizeMake(10, -10);
    //阴影的圆角半径
    layer.shadowRadius = 10;
}

#pragma mark - 图层内容和内容模式_01
- (void)addContentMode {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(20, saveH + 20, 100, 100);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    //设置层内容
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"logo"].CGImage);
    //内容模式，类似于UIImageView的contentMode。默认是填充整个区域 kCAGravityResize
    //kCAGravityResizeAspectFill 这个会向左边靠 贴到view的边边上
    //kCAGravityResizeAspect 这个好像就是按比例了 反正是长方形
    layer.contentsGravity = kCAGravityResizeAspect;
    //设置控制器视图的背景图片 性能很高。 /
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"logo"].CGImage);
}

@end
