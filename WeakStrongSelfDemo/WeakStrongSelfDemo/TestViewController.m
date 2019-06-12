//
//  TestViewController.m
//  WeakStrongSelfDemo
//
//  Created by cs on 2019/6/9.
//  Copyright © 2019 cs. All rights reserved.
//

#import "TestViewController.h"
#import "Student.h"

typedef void(^MyBlock)(void);

@interface TestViewController ()
/** myBlock */
@property(nonatomic, copy)MyBlock myBlock;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试页面";
    
//    [self test1];
    
//    [self test2];
    
    [self test3];
}

- (void)test1 {
    // 引用计数
    NSLog(@"self1 内存地址:%p 引用计数:%lu",self,(unsigned long)[self retainCount]);
    
    // 循环引用
    self.myBlock = ^{
        [self test];
    };
    self.myBlock();
}

- (void)test2 {
    // 引用计数
    NSLog(@"self1 内存地址:%p 引用计数:%lu",self,(unsigned long)[self retainCount]);
    
    __weak typeof(self) weakSelf = self;
    NSLog(@"weakSelf 内存地址:%p 引用计数:%lu",weakSelf,(unsigned long)[weakSelf retainCount]);
    
    NSLog(@"self2 内存地址:%p 引用计数:%lu",self,(unsigned long)[self retainCount]);
    
    // 循环引用
    self.myBlock = ^{
        [weakSelf test];
    };
    self.myBlock();
}

- (void)test3 {
    // 引用计数
    NSLog(@"self1 内存地址:%p 引用计数:%lu",self,(unsigned long)[self retainCount]);
    
    __weak typeof(self) weakSelf = self;
    NSLog(@"weakSelf 内存地址:%p 引用计数:%lu",weakSelf,(unsigned long)[weakSelf retainCount]);
    
    NSLog(@"self2 内存地址:%p 引用计数:%lu",self,(unsigned long)[self retainCount]);
    
    NSLog(@"------------------1---------------------");
    
    // 循环引用
    self.myBlock = ^{
        NSLog(@"block self = %lu",(unsigned long)[self retainCount]);
        
        NSLog(@"block weakSelf = %lu",(unsigned long)[weakSelf retainCount]);
        
        NSLog(@"---------------------2------------------");
        
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        NSLog(@"block self = %lu",(unsigned long)[self retainCount]);
        NSLog(@"block weakSelf = %lu",(unsigned long)[weakSelf retainCount]);
        NSLog(@"block strongSelf = %lu",(unsigned long)[strongSelf retainCount]);;
        
        NSLog(@"-----------------3----------------------");
        
        for (int i = 0; i < 5; i++) {
            NSLog(@"block self = %lu",(unsigned long)[self retainCount]);
        }
        
        for (int i = 0; i < 5; i++) {
            NSLog(@"block weakSelf = %lu",(unsigned long)[weakSelf retainCount]);
        }
        
        for (int i = 0; i < 5; i++) {
            NSLog(@"block strongSelf = %lu",(unsigned long)[strongSelf retainCount]);
        }
    };
    self.myBlock();
}

- (void)test4 {
    
// 引用计数
for (int i = 0; i < 3; i++) {
    NSLog(@"self1 内存地址:%p 引用计数:%lu",self,(unsigned long)[self retainCount]);
}

__weak typeof(self) weakSelf = self;
for (int i = 0; i < 3; i++) {
    NSLog(@"weakSelf 内存地址:%p",weakSelf);
}
NSLog(@"引用计数:%lu",(unsigned long)[weakSelf retainCount]);
NSLog(@"----------------0--------------");

for (int i = 0; i < 3; i++) {
    NSLog(@"引用计数:%lu",(unsigned long)[weakSelf retainCount]);
}

NSLog(@"self2 内存地址:%p 引用计数:%lu",self,(unsigned long)[self retainCount]);
NSLog(@"weakSelf 内存地址:%p 引用计数:%lu",weakSelf,(unsigned long)[weakSelf retainCount]);
    
    NSLog(@"------------------1---------------------");
    
    // 循环引用
    self.myBlock = ^{
        NSLog(@"block self = %lu",(unsigned long)[self retainCount]);
        
        NSLog(@"block weakSelf = %lu",(unsigned long)[weakSelf retainCount]);
        
        NSLog(@"---------------------2------------------");
        
        __strong typeof (weakSelf) strongSelf = weakSelf;
        
        NSLog(@"block self = %lu",(unsigned long)[self retainCount]);
        NSLog(@"block weakSelf = %lu",(unsigned long)[weakSelf retainCount]);
        NSLog(@"block strongSelf = %lu",(unsigned long)[strongSelf retainCount]);;
        
        NSLog(@"-----------------3----------------------");
        
        for (int i = 0; i < 5; i++) {
            NSLog(@"block self = %lu",(unsigned long)[self retainCount]);
        }
        
        for (int i = 0; i < 5; i++) {
            NSLog(@"block weakSelf = %lu",(unsigned long)[weakSelf retainCount]);
        }
        
        for (int i = 0; i < 5; i++) {
            NSLog(@"block strongSelf = %lu",(unsigned long)[strongSelf retainCount]);
        }
    };
    self.myBlock();
}

- (void)test5 {
    Student *stu = [[Student alloc] init];
    __weak Student *weakStu = stu;
    
    self.myBlock = ^{
        NSLog(@"%p",stu);
        NSLog(@"%p",weakStu);
    };
    self.myBlock();
}

//struct __main_block_impl_0 {
//    NSObject *__weak weakStu;
//}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
    [super dealloc];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan self 内存地址:%p 引用计数:%lu",self,(unsigned long)[self retainCount]);
}

- (void)test {
    NSLog(@"test方法 self 内存地址:%p 引用计数:%lu",self,(unsigned long)[self retainCount]);
}

@end
