//
//  BaseItem.m
//  AnimationDemo
//
//  Created by cs on 2018/10/6.
//  Copyright © 2018 cs. All rights reserved.
//

#import "BaseItem.h"

@implementation BaseItem
+ (instancetype)baseItemWithTitle:(NSString *)title code:(NSString *)code {
    BaseItem *item = [[BaseItem alloc] init];
    item.title = title;
    item.code = code;
    return item;
}
@end
