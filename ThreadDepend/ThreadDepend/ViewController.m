//
//  ViewController.m
//  ThreadDepend
//
//  Created by cs on 2019/4/1.
//  Copyright © 2019 cs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self gcdDependTest];
//    [self gcdDependTest2];
//    [self gcdDependTest3];
//    [self nsoperationDependTest];
    [self dispatchBarrierAsyncTest];
}

- (void)gcdDependTest {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i  = 0; i < 10000; i++) {
            //just for delayed
        }
        sleep(1);
        NSLog(@"dispatch semaphore send");
        dispatch_semaphore_signal(semaphore);
    });
    NSLog(@"waiting...");
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"function end");
}

- (void)gcdDependTest2 {
    // 线程一做事情
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程一做事情");
        for (int i  = 0; i < 10000; i++) {
            //just for delayed
        }
        sleep(1);
        NSLog(@"dispatch1 semaphore send");
    });

    // 线程二做事情
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程二做事情");
        for (int i  = 0; i < 10000; i++) {
            //just for delayed
        }
        sleep(1);
        NSLog(@"dispatch2 semaphore send");
    });

    // 线程二做事情
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程三做事情");
        for (int i  = 0; i < 10000; i++) {
            //just for delayed
        }
        sleep(1);
        NSLog(@"dispatch3 semaphore send");
    });
    
    NSLog(@"function end");
}

- (void)gcdDependTest3 {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);  // 信号量初始化为0
    
    // 线程一做事情
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程一做事情");
        for (int i  = 0; i < 10000; i++) {
            //just for delayed
        }
        sleep(1);
        NSLog(@"dispatch1 semaphore send");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    // 线程二做事情
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程二做事情");
        for (int i  = 0; i < 10000; i++) {
            //just for delayed
        }
        sleep(1);
        NSLog(@"dispatch2 semaphore send");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    // 线程二做事情
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程三做事情");
        for (int i  = 0; i < 10000; i++) {
            //just for delayed
        }
        sleep(1);
        NSLog(@"dispatch3 semaphore send");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"function end");
}


- (void)nsoperationDependTest {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            
        }
        sleep(1);
        NSLog(@"op1 is finish");
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 10000; i++) {
            
        }
        sleep(1);
        NSLog(@"op2 is finish");
    }];
    [op1 addDependency:op2];
    [queue addOperation:op1];
    [queue addOperation:op2];
}

- (void)dispatchBarrierAsyncTest {
//    dispatch_queue_t queue = dispatch_queue_create("gcd.barrier.async", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_queue_create("gcd.barrier.async", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"dispatch_async1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async2");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_async");
        [NSThread sleepForTimeInterval:0.5];
        
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async3");
    });
}

@end
