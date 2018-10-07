//
//  ActivityIndicatorView.h
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/7.
//  Copyright © 2018年 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 核心动画之CALayer的Mask实现注水动画效果 */
@interface ActivityIndicatorView : UIView
@property (nonatomic, assign) BOOL hidesWhenStopped;

- (void)startAnimation;
- (void)stopAnimation;
@end
