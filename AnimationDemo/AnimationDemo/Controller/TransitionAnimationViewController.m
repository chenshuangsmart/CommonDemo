//
//  TransitionAnimationViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/14.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "TransitionAnimationViewController.h"
#define kImageCount 8

@interface TransitionAnimationViewController ()
@property (nonatomic, strong) UIImageView *myImageView;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation TransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"转场动画";
    
    self.myImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.myImageView.image = [UIImage imageNamed:@"0"];
    self.myImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_myImageView];
    
    //添加手势
    UISwipeGestureRecognizer* leftSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer* rightSwipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
}

#pragma mark - 向左滑动浏览下张图片

- (void)leftSwipe:(UISwipeGestureRecognizer*)gesture {
    [self transitionAnimtion:YES];
}

#pragma mark - 向右滑动浏览上张图片

- (void)rightSwipe:(UISwipeGestureRecognizer*)gesture {
    [self transitionAnimtion:NO];
}

#pragma mark - 添加转场动画

- (void)transitionAnimtion:(BOOL)flag {
    //1.创建转场动画对象
    CATransition* transition = [[CATransition alloc]init];
    
    //2.设置动画类型，注意对于苹果官方没有公开的动画类型只能使用字符串，并没有对应的常亮使用
    transition.type = @"cube";
    //设置子类型
    if (flag) {
        transition.subtype = kCATransitionFromRight;
    } else {
        transition.subtype = kCATransitionFromLeft;
    }
    
    //设置动画时长
    transition.duration = 1.0f;
    
    //3.设置转场动画后,给新视图添加转场动画
    self.myImageView.image = [self getImage:flag];
    [self.myImageView.layer addAnimation:transition forKey:@"abc"];
}

- (UIImage*)getImage:(BOOL)flag {
    if (flag) {
        self.currentIndex = ++self.currentIndex % kImageCount;
    } else {
        self.currentIndex = --self.currentIndex % kImageCount;
    }
    
    return [UIImage imageNamed:[NSString stringWithFormat:@"%ld",self.currentIndex]];
}


@end
