//
//  BaseViewController.h
//  AnimationDemo
//
//  Created by chenshuang on 2018/10/8.
//  Copyright © 2018年 cs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@interface BaseViewController : UIViewController

- (UIButton *)addBtnWithTitle:(NSString *)title action:(SEL)action;

@end
