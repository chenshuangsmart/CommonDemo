//
//  ViewController.m
//  CallClassMethodNoCategory
//
//  Created by cs on 2019/6/25.
//  Copyright © 2019 cs. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import <objc/runtime.h>

/**
 ios 分类重写原类方法时，调用原类方法
 */
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self test];
    
//    [self getAllClassMethod];
    
    [self callClassMethod];
}

- (void)test {
    Student *stu = [[Student alloc] init];
    [stu run];
}

- (void)getAllClassMethod {
    u_int count;
    Method *methods = class_copyMethodList([Student class], &count);
    NSInteger index = 0;
    
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        IMP imp = method_getImplementation(methods[i]);
        const char *encode = method_getTypeEncoding(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        
        NSLog(@"%s",encode);
        NSLog(@"%@",strName);
        NSLog(@"----------------------");
    }
}

- (void)callClassMethod {
    u_int count;
    Method *methods = class_copyMethodList([Student class], &count);
    NSInteger index = 0;
    
    for (int i = 0; i < count; i++) {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];

        if ([strName isEqualToString:@"run"]) {
            index = i;  // 先获取原类方法在方法列表中的索引
        }
    }
    
    // 调用方法
    Student *stu = [[Student alloc] init];
    SEL sel = method_getName(methods[index]);
    IMP imp = method_getImplementation(methods[index]);
    ((void (*)(id, SEL))imp)(stu,sel);
}

@end
