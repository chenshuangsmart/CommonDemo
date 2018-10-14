//
//  CustomLayerDrawInRectViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/8.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "CustomLayerDrawInRectViewController.h"
#import "CustomView.h"

@interface CustomLayerDrawInRectViewController ()

@end

@implementation CustomLayerDrawInRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CustomView* view = [[CustomView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249/255.0 alpha:1];
    [self.view addSubview:view];
}

@end
