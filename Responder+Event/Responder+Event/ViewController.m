//
//  ViewController.m
//  Responder+Event
//
//  Created by cs on 2018/10/6.
//  Copyright © 2018 cs. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "RedView.h"
#import "GreenView.h"
#import "YellowView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self drawUI];
    
//    [self drawUI1];
    
    [self hitTest];
}

- (void)drawUI {
    TestView *testView = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.userInteractionEnabled = NO;
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
}

- (void)drawUI1 {
    CGFloat viewW = self.view.bounds.size.width;
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake((viewW - 200) * 0.5, 100, 200, 100)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:greenView];
    
    UIView *orangeView = [[UIView alloc] initWithFrame:CGRectMake((viewW - 250) * 0.5, 220, 250, 180)];
    orangeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:orangeView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake((250 - 150) * 0.5, 20, 150, 100)];
    blueView.backgroundColor = [UIColor blueColor];
    [orangeView addSubview:blueView];
    
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(30, 10, 100, 50)];
    yellowView.backgroundColor = [UIColor yellowColor];
    [blueView addSubview:yellowView];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(120, 100, 100, 50)];
    redView.backgroundColor = [UIColor redColor];
    [orangeView addSubview:redView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}

- (void)hitTest {
    CGFloat viewW = self.view.bounds.size.width;
    
    RedView *redView = [[RedView alloc] initWithFrame:CGRectMake((viewW - 200) * 0.5, 100, 200, 250)];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    GreenView *greenView = [[GreenView alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
    greenView.backgroundColor = [UIColor greenColor];
    [redView addSubview:greenView];
    
    YellowView *yellowView = [[YellowView alloc] initWithFrame:CGRectMake(50, 150, 200, 50)];
    yellowView.backgroundColor = [UIColor yellowColor];
    [redView addSubview:yellowView];
}

@end
