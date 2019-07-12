//
//  CSNotification.h
//  NotificationTheory
//
//  Created by cs on 2019/7/8.
//  Copyright © 2019 cs. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 如果需要每个属性或每个方法都去指定nonnull和nullable，是一件非常繁琐的事。苹果为了减轻我们的工作量，专门提供了两个宏
 NS_ASSUME_NONNULL_BEGIN
 NS_ASSUME_NONNULL_END
 */
NS_ASSUME_NONNULL_BEGIN

/**
  关于通知实例对象的封装
 */
@interface CSNotification : NSObject
/** name */
@property(nonatomic, copy)NSString *name;
/** object */
@property(nullable, readonly, retain)id object;
/** userInfo */
@property(nullable, readonly, copy)NSDictionary *userInfo;

/**
 初始化方法

 @param name name
 @param object object
 @param userInfo userInfo
 @return 通知实例对象
 */
- (instancetype)initWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

+ (instancetype)initWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
