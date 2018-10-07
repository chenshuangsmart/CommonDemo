//
//  ProgressLayer.h
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/7.
//  Copyright © 2018年 cs. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef void(^ZXProgressReport)(NSUInteger progress,CGRect textRect, CGColorRef textColor) ;

@interface ProgressLayer : CALayer
@property (nonatomic, assign) float strokeEnd;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign) CGColorRef strokeColor;
@property (nonatomic, assign) CGColorRef fillColor;
@property (nonatomic, copy) ZXProgressReport report;
@end
