//
//  AppEnvs.h
//  iPhoneX-adaption
//
//  Created by chenshuang on 2018/10/3.
//  Copyright © 2018年 wenwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppEnvs : NSObject

#pragma mark - 相关变量值
@property(nonatomic, assign) int screenWidth;   // 屏幕宽度
@property(nonatomic, assign) int screenHeight;  // 屏幕高度
@property(nonatomic, assign) int statusBarHeight; // 系统状态栏高度
@property(nonatomic, assign) int tabBarHeight; // 系统TabBar高度 + 安全距离
@property(nonatomic, assign) int safeAreaBottomHeight; //iPhone X 安全距离
@property(nonatomic, assign) int navBarHeight;  // 导航栏高度
@property(nonatomic, assign) int navHeight; // 状态栏 + 导航栏
@property(nonatomic, assign) int screenHeightTabBar; // 屏幕高度 - 状态栏 - 导航栏 - tabBar - 安全距离
@property(nonatomic, assign) int screenHeightTabBarNoNavBar;    // 屏高 - 状态栏高度 - tabBar - 安全距离
@property(nonatomic, assign) int screenHeightNoNavBar;  // 屏高 - 状态栏 - 导航栏 - 安全距离
@property(nonatomic, assign) int screenHeightNoStatusBar;   // 屏幕高度 - 状态栏

#pragma mark - 机型
@property(nonatomic, assign) bool isIPhone4;
@property(nonatomic, assign) bool isIPhone5;
@property(nonatomic, assign) bool isIPhone6;
@property(nonatomic, assign) bool isIPhone6Plus;
@property(nonatomic, assign) bool isIPhoneBig;
@property(nonatomic, assign) bool isIphoneX;

@end
