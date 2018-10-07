//
//  LayerAnimateViewController.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/7.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "LayerAnimateViewController.h"
#import "ProgressView.h"
#import "UIView+Extension.h"

@interface LayerAnimateViewController ()
/** progressView*/
@property(nonatomic,strong)ProgressView *progressView;
/** slide*/
@property(nonatomic,strong)UISlider *slideView;
@end

@implementation LayerAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawUI];
}

- (void)drawUI {
    self.progressView.centerX = self.view.width * 0.5;
    self.progressView.y = 100;
    [self.view addSubview:self.progressView];
    
    self.slideView.centerX = self.view.width * 0.5;
    self.slideView.y = self.view.height - 200;
    [self.view addSubview:self.slideView];
}

-(void)sliderValueChanged:(UISlider *)slider {
    self.progressView.progress = slider.value;
}

#pragma mark - lazy

- (ProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[ProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.8, 100)];
    }
    return _progressView;
}

- (UISlider *)slideView {
    if (_slideView == nil) {
        _slideView = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.8, 50)];
        [_slideView addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slideView;
}
@end
