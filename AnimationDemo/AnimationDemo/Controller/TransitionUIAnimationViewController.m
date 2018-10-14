//
//  TransitionUIAnimationViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/14.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "TransitionUIAnimationViewController.h"

#define IMAGE_COUNT 8

@interface TransitionUIAnimationViewController ()

@end

@implementation TransitionUIAnimationViewController {
    UIImageView *_imageView;
    int _currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //定义图片控件
    _imageView=[[UIImageView alloc]init];
    _imageView.frame=[UIScreen mainScreen].applicationFrame;
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    _imageView.image=[UIImage imageNamed:@"0.jpg"];//默认图片
    [self.view addSubview:_imageView];
    
    //添加手势
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
         
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
}

#pragma mark 向左滑动浏览下一张图片

-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}
 
#pragma mark 向右滑动浏览上一张图片

-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}

#pragma mark 转场动画

-(void)transitionAnimation:(BOOL)isNext{
    UIViewAnimationOptions option;
    if (isNext) {
        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromRight;
    } else {
        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromLeft;
    }
         
    [UIView transitionWithView:_imageView duration:1.0 options:option animations:^{
        _imageView.image=[self getImage:isNext];
    } completion:nil];
}
 
#pragma mark 取得当前图片

-(UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        _currentIndex = ++_currentIndex % IMAGE_COUNT;
    } else {
        _currentIndex = --_currentIndex % IMAGE_COUNT;
    }
    NSString *imageName=[NSString stringWithFormat:@"%i.jpg",_currentIndex];
    return [UIImage imageNamed:imageName];
}

@end
