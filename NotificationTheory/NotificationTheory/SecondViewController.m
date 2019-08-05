//
//  SecondViewController.m
//  NotificationTheory
//
//  Created by cs on 2019/7/9.
//  Copyright © 2019 cs. All rights reserved.
//

#import "SecondViewController.h"
#import "CSNotificationCenter.h"

static NSString *kTextFieldValueChange = @"kTextFieldValueChange";

@interface SecondViewController ()
/** textField */
@property(nonatomic, weak)UITextField *textF;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self drawUI];
}

#pragma mark - drawUI

- (void)drawUI {
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    textF.textColor = [UIColor blackColor];
    textF.layer.borderWidth = 1;
    textF.layer.borderColor = [[UIColor grayColor] CGColor];
    textF.center = self.view.center;
    [self.view addSubview:self.textF = textF];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapSend) forControlEvents:UIControlEventTouchUpInside];
    btn.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.7);
    [self.view addSubview:btn];
}

#pragma mark - action

- (void)tapSend {
    if (self.textF.text.length <= 0) {
        [[[UIAlertView alloc]initWithTitle:@"错误" message:@"UITextfield的文本不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
        return;
    }
    
    // 发送通知 - 系统
    [[NSNotificationCenter defaultCenter] postNotificationName:kTextFieldValueChange object:self.textF.text];
    
    // 发送通知 - 自定义
    [[CSNotificationCenter defaultCenter] postNotificationName:kTextFieldValueChange object:self.textF.text];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
