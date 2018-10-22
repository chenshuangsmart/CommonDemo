//
//  ViewController.m
//  DragImage
//
//  Created by chenshuang on 2018/10/21.
//  Copyright © 2018年 wenwen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 原始方式
    [self drawImg];
    
    // 方式一
//    [self drawImg1];
    
    // 方式二
//    [self drawImg2];
    
    // 方式三
//    [self drawImg3];
    
}

// 原始图片
- (void)drawImg {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    imgView.image = [UIImage imageNamed:@"img4"];
    imgView.center = self.view.center;
    [self.view addSubview:imgView];
}

// 方式一
- (void)drawImg1 {
    UIImage *img = [UIImage imageNamed:@"img4"];
    // 设置左边端盖宽度
    NSInteger leftCapWidth = img.size.width * 0.5;
    // 设置上边端盖高度
    NSInteger topCapHeight = img.size.height * 0.5;
    
    UIImage *newImg = [img stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    imgView.image = newImg;
    imgView.center = self.view.center;
    [self.view addSubview:imgView];
}

- (void)drawImg2 {
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"img4"];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    // 拉伸图片
    UIImage *newImg = [image resizableImageWithCapInsets:edgeInsets];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    imgView.image = newImg;
    imgView.center = self.view.center;
    [self.view addSubview:imgView];
}

- (void)drawImg3 {
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"img4"];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeTile;
    
    // 拉伸图片
    UIImage *newImg = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    imgView.image = newImg;
    imgView.center = self.view.center;
    [self.view addSubview:imgView];
}



@end
