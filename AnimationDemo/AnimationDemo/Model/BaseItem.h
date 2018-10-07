//
//  BaseItem.h
//  AnimationDemo
//
//  Created by cs on 2018/10/6.
//  Copyright © 2018 cs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseItem : NSObject
/** title */
@property(nonatomic, strong)NSString *title;
/** code */
@property(nonatomic, strong)NSString *code;

+ (instancetype)baseItemWithTitle:(NSString *)title code:(NSString *)code;

@end
