//
//  CSNotificationCenter.h
//  NotificationTheory
//
//  Created by cs on 2019/7/8.
//  Copyright © 2019 cs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNotification.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSNotificationCenter : NSObject

/// 单例
+ (CSNotificationCenter *)defaultCenter;

#pragma mark - 添加通知

- (void)addObserver:(nonnull id)observer selector:(nonnull SEL)selector name:(nullable NSString *)name object:(nullable id)object;

- (id <NSObject>)addObserverForName:(nullable NSString *)name object:(nullable id)object queue:(nullable NSOperationQueue *)queue usingBlock:(void(^)(CSNotification * _Nonnull note))block;

#pragma mark - 接收通知

- (void)postNotification:(CSNotification *)notification;

- (void)postNotificationName:(nonnull NSString *)name object:(nullable id)object;

- (void)postNotificationName:(nonnull NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

#pragma mark - 移除通知

- (void)removeObserver:(nonnull id)observer;

- (void)removeObserver:(nonnull id)observer name:(nullable NSString *)name object:(nullable id)object;

@end

NS_ASSUME_NONNULL_END
