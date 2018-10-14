//
//  SpringAnimationViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/14.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "SpringAnimationViewController.h"

@interface SpringAnimationViewController ()

@end

@implementation SpringAnimationViewController {
    UIImageView *_imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建图像显示控件
    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ball"]];
    _imageView.size = CGSizeMake(100, 100);
    _imageView.center=CGPointMake(160, 50);
    [self.view addSubview:_imageView];
}

#pragma mark 点击事件

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    CGPoint location= [touch locationInView:self.view];
    /*创建弹性动画
     damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
     velocity:弹性复位的速度
     */
    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _imageView.center=location; //CGPointMake(160, 284);
    } completion:nil];
}
@end
