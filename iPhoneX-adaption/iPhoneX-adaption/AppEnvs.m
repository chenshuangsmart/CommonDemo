//
//  AppEnvs.m
//  iPhoneX-adaption
//
//  Created by chenshuang on 2018/10/3.
//  Copyright © 2018年 wenwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppEnvs.h"

@implementation AppEnvs
- (instancetype)init {
    self = [super init];
    if (self) {
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        _statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _safeAreaBottomHeight = _screenHeight == 812.0 ? 34 : 0;
        _navBarHeight = 44;
        
        _navHeight = _navBarHeight + _statusBarHeight;
        _tabBarHeight = ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49);
        _screenHeightNoNavBar = _screenHeight - _navHeight - _safeAreaBottomHeight;
        _screenHeightTabBar = _screenHeight - _navHeight - _tabBarHeight;
        _screenHeightTabBarNoNavBar = _screenHeight - _statusBarHeight - _tabBarHeight;
        _screenHeightNoStatusBar = _screenHeight - _statusBarHeight;
        
        // 机型
        if (_screenHeight == 812) {
            _isIphoneX = YES;
        } else if (_screenWidth > 370 && _screenWidth < 400 && _screenHeight != 812) {
            _isIPhone6 = YES;
        } else if (_screenWidth > 400 && _screenHeight != 812) {
            _isIPhone6Plus = YES;
        } else if (_screenWidth == 320 && _screenHeight == 568) {
            _isIPhone5 = YES;
        } else if (_screenWidth == 320 && _screenHeight == 480) {
            _isIPhone4 = YES;
        }
        
        if (_screenWidth > 370) {
            _isIPhoneBig = YES;
        }
    }
    return self;
}
@end
