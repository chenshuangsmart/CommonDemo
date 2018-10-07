//
//  RedView.m
//  Responder+Event
//
//  Created by cs on 2018/10/6.
//  Copyright © 2018 cs. All rights reserved.
//

#import "RedView.h"

@implementation RedView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"RedView touchesBegan");
}

// 不管点击哪里,都让绿色视图处理事件
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    return self.subviews[0];
//}

// 自身触摸不响应事件,如果子控件触摸,正常响应事件
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//    if (view == self) {
//        return nil;
//    }
//    return view;
//}

// 作用:判断下传入过来的点在不在方法调用者的坐标系上
// point:是方法调用者坐标系上的点
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
// return NO;
//}

@end
