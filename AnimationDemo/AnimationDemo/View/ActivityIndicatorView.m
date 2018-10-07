//
//  ActivityIndicatorView.m
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/7.
//  Copyright © 2018年 cs. All rights reserved.
//

#import "ActivityIndicatorView.h"
#import "UIView+Extension.h"

@interface ActivityIndicatorView()
@property (nonatomic, strong) UIImageView *animationCircle;
@end

@implementation ActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    UIImageView *logo = [[UIImageView alloc] initWithFrame:self.bounds];
    logo.image = [UIImage imageNamed:@"loading_logo"];
    logo.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    [self addSubview:logo];
    
    self.animationCircle = [[UIImageView alloc] initWithFrame:self.bounds];
    self.animationCircle.image = [UIImage imageNamed:@"loading_indicator"];
    self.animationCircle.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    [self addSubview:self.animationCircle];
}

- (void)startAnimation {
    CAAnimation * existAnimation = [self.animationCircle.layer animationForKey:@"rotate"];
    if (existAnimation) {
        return;
    }
    
    self.hidden = NO;
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0;
    animation.toValue = @(2*M_PI);
    animation.duration = 1.5f;
    animation.repeatCount = HUGE_VALF;
    [self.animationCircle.layer addAnimation:animation forKey:@"rotate"];
}

- (void)stopAnimation {
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }
    
    [self.animationCircle.layer removeAllAnimations];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    self.bounds = CGRectMake(0, 0, 30.f, 30.f);
}

@end
