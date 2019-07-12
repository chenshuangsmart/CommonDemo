//
//  CSNotificationCenter.m
//  NotificationTheory
//
//  Created by cs on 2019/7/8.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSNotificationCenter.h"

#pragma mark - CSObserverModel

typedef void(^operationBlock)(CSNotification *notification);

/**
 观察者模型对象
 */
@interface CSObserverModel : NSObject
/** 观察者对象 */
@property(nonatomic, strong)id observer;
/** 执行的方法 */
@property(nonatomic, assign)SEL selector;
/** 通知名字 */
@property(nonatomic, copy)NSString *notificationName;
/** 携带的参数 */
@property(nonatomic, strong)id object;
/** 队列 */
@property(nonatomic, strong)NSOperationQueue *operationQueue;
/** 回调 */
@property(nonatomic, copy)operationBlock block;
@end

@implementation CSObserverModel

@end

#pragma mark - CSNotificationCenter

@interface CSNotificationCenter()

/** observerJson key:NotificationName value:observes */
@property(nonatomic, strong)NSMutableDictionary *observerJson;

@end

@implementation CSNotificationCenter

/// 单例
+ (CSNotificationCenter *)defaultCenter {
    static CSNotificationCenter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.observerJson = [NSMutableDictionary dictionary];
    });
    return instance;
}

#pragma mark - 添加通知

- (void)addObserver:(nonnull id)observer selector:(nonnull SEL)selector name:(nullable NSString *)name object:(nullable id)object {
    // 创建数据模型
    CSObserverModel *observerModel = [[CSObserverModel alloc] init];
    observerModel.observer = observer;
    observerModel.selector = selector;
    observerModel.notificationName = name;
    observerModel.object = object;
    
    // 如果不存在,才创建
    if (![self.observerJson objectForKey:name]) {
        NSMutableArray *arrays = [NSMutableArray array];
        
        [arrays addObject:observerModel];
        
        // 添加进 json 中
        [self.observerJson setObject:arrays forKey:name];
    } else {
        // 如果存在,取出来,继续添加进对应数组即可
        NSMutableArray *arrays = (NSMutableArray *)[self.observerJson objectForKey:name];
        
        [arrays addObject:observerModel];
    }
}

- (id <NSObject>)addObserverForName:(nullable NSString *)name object:(nullable id)object queue:(nullable NSOperationQueue *)queue usingBlock:(void(^)(CSNotification * _Nonnull note))block {
    // 创建数据模型
    CSObserverModel *observerModel = [[CSObserverModel alloc] init];
    observerModel.block = block;
    observerModel.operationQueue = queue;
    observerModel.notificationName = name;
    observerModel.object = object;
    
    // 如果不存在,才创建
    if (![self.observerJson objectForKey:name]) {
        NSMutableArray *arrays = [NSMutableArray array];
        
        [arrays addObject:observerModel];
        
        // 添加进 json 中
        [self.observerJson setObject:arrays forKey:name];
    } else {
        // 如果存在,取出来,继续添加进对应数组即可
        NSMutableArray *arrays = (NSMutableArray *)[self.observerJson objectForKey:name];
        
        [arrays addObject:observerModel];
    }
    
    return nil;
}

#pragma mark - 接收通知

- (void)postNotification:(CSNotification *)notification {
    // 根据 name 取出对应观察者数组,执行任务
    NSMutableArray *arrays = (NSMutableArray *)[self.observerJson objectForKey:notification.name];
    
    [arrays enumerateObjectsUsingBlock:^( CSObserverModel *observerModel, NSUInteger idx, BOOL *stop) {
        // 取出数据模型
        id observer = observerModel.observer;
        SEL selector = observerModel.selector;
        
        if (!observerModel.operationQueue) {
            // 下面这样写的目的是:手动忽略clang编译器警告
            // 参考:http://blog.csdn.net/qq_18505715/article/details/76087558
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [observer performSelector:selector withObject:notification];
#pragma clang diagnostic pop
        } else {
            // 创建任务
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                // 这里通过 block 回调出去
                observerModel.block(notification);
            }];
            
            // 如果添加观察者 传入 队列，那么任务就放在队列中执行(子线程异步执行)
            [observerModel.operationQueue addOperation:operation];
        }
    }];
}

- (void)postNotificationName:(nonnull NSString *)name object:(nullable id)objec {
    [self postNotificationName:name object:objec userInfo:nil];
};

- (void)postNotificationName:(nonnull NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo {
    CSNotification *notification = [[CSNotification alloc] initWithName:name object:object userInfo:userInfo];
    [self postNotification:notification];
}

#pragma mark - 移除通知

- (void)removeObserver:(nonnull id)observer {
    [self removeObserver:observer name:nil object:nil];
}

- (void)removeObserver:(nonnull id)observer name:(nullable NSString *)name object:(nullable id)object {
    // 移除观察者 - 当有 name 参数时
    if (name.length > 0 && [self.observerJson objectForKey:name]) {
        NSMutableArray *arrays = (NSMutableArray *)[self.observerJson objectForKey:name];
        [arrays removeObject:observer];
    } else {
        // 移除观察者 - 当没有 name 参数时
        if (self.observerJson.allKeys.count > 0 && self.observerJson.allValues.count > 0) {
            NSArray *allKeys = self.observerJson.allKeys;
            
            for (int i = 0; i < allKeys.count; i++) {
                NSMutableArray *keyOfAllObservers = [self.observerJson objectForKey:allKeys[i]];
                
                BOOL isStop = NO;   // 如果找到后就不再遍历后面的数据了
                
                for (int j = 0; j < keyOfAllObservers.count; j++) {
                    // 取出数据模型
                    CSObserverModel *observerModel = keyOfAllObservers[j];
                    
                    if (observerModel.observer == observer) {
                        [keyOfAllObservers removeObject:observerModel];
                        isStop = YES;
                        break;
                    }
                }
                
                if (isStop) {   // 找到了,退出循环
                    break;
                }
            }
        } else {
            NSAssert(false, @"当前通知中心没有观察者");
        }
    }
}

@end
