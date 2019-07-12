//
//  CSNotification.m
//  NotificationTheory
//
//  Created by cs on 2019/7/8.
//  Copyright © 2019 cs. All rights reserved.
//

#import "CSNotification.h"

@implementation CSNotification

- (instancetype)init {
    NSAssert(false, @"do not invoke; not a valid initializer for this class");
    return nil;
}

- (instancetype)initWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo {
    self = [super init];
    if (self) {
        _name = name;
        _object = object;
        _userInfo = userInfo;
    }
    return self;
}

+ (instancetype)initWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo {
    return [[self alloc] initWithName:name object:object userInfo:userInfo];
}

@end
