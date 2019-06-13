//
//  UIButton+Extension.m
//  AvoidBtnRepeatClick
//
//  Created by cs on 2019/6/13.
//  Copyright © 2019 wenwen. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

static char *const kEventIntervalKey = "kEventIntervalKey"; // 时间间隔
static char *const kEventInvalidKey = "kEventInvalidKey";   // 是否失效

@interface UIButton()

/** 是否失效 - 即不可以点击 */
@property(nonatomic, assign)BOOL cs_eventInvalid;

@end

@implementation UIButton (Extension)

+ (void)load {
    // 交换方法
    Method clickMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method cs_clickMethod = class_getInstanceMethod(self, @selector(cs_sendAction:to:forEvent:));
    method_exchangeImplementations(clickMethod, cs_clickMethod);
}

#pragma mark - click

- (void)cs_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (!self.cs_eventInvalid) {
        self.cs_eventInvalid = YES;
        [self cs_sendAction:action to:target forEvent:event];
        [self performSelector:@selector(setCs_eventInvalid:) withObject:@(NO) afterDelay:self.cs_eventInterval];
    }
}

#pragma mark - set | get

- (NSTimeInterval)cs_eventInterval {
    return [objc_getAssociatedObject(self, kEventIntervalKey) doubleValue];
}

- (void)setCs_eventInterval:(NSTimeInterval)cs_eventInterval {
    objc_setAssociatedObject(self, kEventIntervalKey, @(cs_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cs_eventInvalid {
    return [objc_getAssociatedObject(self, kEventInvalidKey) boolValue];
}

- (void)setCs_eventInvalid:(BOOL)cs_eventInvalid {
    objc_setAssociatedObject(self, kEventInvalidKey, @(cs_eventInvalid), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
