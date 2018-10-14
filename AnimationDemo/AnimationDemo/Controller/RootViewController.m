//
//  RootViewController.m
//  AnimationDemo
//
//  Created by cs on 2018/10/6.
//  Copyright © 2018 cs. All rights reserved.
//

#import "RootViewController.h"
#import "BaseItem.h"
#import "AnimateViewController.h"
#import "LayerTransformViewController.h"
#import "LayerAnimateViewController.h"
#import "ActivityIndicatorViewController.h"
#import "CALayerDefaultAnimationVC.h"
#import "CALayerDrawInRectViewController.h"
#import "CustomLayerDrawInRectViewController.h"
#import "CoreAnimationViewController.h"
#import "CoreAnimation2ViewController.h"
#import "KeyFrameAnimationViewController.h"
#import "AnimationGroupViewController.h"
#import "TransitionAnimationViewController.h"
#import "CADisplaylinkAnimationViewController.h"
#import "AnimationFromUIViewController.h"
#import "SpringAnimationViewController.h"
#import "KeyFrameUIAnimationViewController.h"
#import "TransitionUIAnimationViewController.h"

static NSString *CellID = @"CellID";
static NSString *AnimateVCCode = @"AnimateVCCode";
static NSString *LayerTransformVCCode = @"LayerTransformVCCode";
static NSString *LayerAnimateVCCode = @"LayerAnimateVCCode";
static NSString *ActivityIndicatorVCCode = @"ActivityIndicatorVCCode";
static NSString *CALayerDefaultAnimationVCCode = @"CALayerDefaultAnimationVCCode";
static NSString *CALayerDrawInRectVCCode = @"CALayerDrawInRectVCCode";
static NSString *CustomLayerDrawInRectVCCode = @"CustomLayerDrawInRectVCCode";
static NSString *CoreAnimationVCCode = @"CoreAnimationVCCode";
static NSString *CoreAnimation2VCCode = @"CoreAnimation2VCCode";
static NSString *KeyFrameAnimationVCCode = @"KeyFrameAnimationVCCode";
static NSString *AnimationGroupVCCode = @"AnimationGroupVCCode";
static NSString *TransitionAnimationVCCode = @"TransitionAnimationVCCode";
static NSString *CADisplaylinkAnimationVCCode = @"CADisplaylinkAnimationVCCode";
static NSString *AnimationFromUIVCCode = @"AnimationFromUIVCCode";
static NSString *SpringAnimationVCCode = @"SpringAnimationVCCode";
static NSString *KeyFrameUIAnimationVCCode = @"KeyFrameUIAnimationVCCode";
static NSString *TransitionUIAnimationVCCode = @"TransitionUIAnimationVCCode";


@interface RootViewController ()
/** 数据源 */
@property(nonatomic, strong)NSMutableArray *datas;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    
    [self setupData];
}

- (void)setupData {
    BaseItem *item1 = [BaseItem baseItemWithTitle:@"UIView 动画实现原理" code:AnimateVCCode];
    BaseItem *item2 = [BaseItem baseItemWithTitle:@"Layer动画" code:LayerTransformVCCode];
    BaseItem *item3 = [BaseItem baseItemWithTitle:@"Layer-进度条和水滴" code:LayerAnimateVCCode];
    BaseItem *item4 = [BaseItem baseItemWithTitle:@"注水动画效果" code:ActivityIndicatorVCCode];
    BaseItem *item5 = [BaseItem baseItemWithTitle:@"核心动画CoreAnimation" code:CALayerDefaultAnimationVCCode];
    BaseItem *item6 = [BaseItem baseItemWithTitle:@"CALayer绘图" code:CALayerDrawInRectVCCode];
    BaseItem *item7 = [BaseItem baseItemWithTitle:@"使用自定义图层绘图" code:CustomLayerDrawInRectVCCode];
    BaseItem *item8 = [BaseItem baseItemWithTitle:@"Core Animation" code:CoreAnimationVCCode];
    BaseItem *item9 = [BaseItem baseItemWithTitle:@"Core Animation2" code:CoreAnimation2VCCode];
    BaseItem *item10 = [BaseItem baseItemWithTitle:@"关键帧动画" code:KeyFrameAnimationVCCode];
    BaseItem *item11 = [BaseItem baseItemWithTitle:@"动画组" code:AnimationGroupVCCode];
    BaseItem *item12 = [BaseItem baseItemWithTitle:@"转动动画" code:TransitionAnimationVCCode];
    BaseItem *item13 = [BaseItem baseItemWithTitle:@"逐帧动画" code:CADisplaylinkAnimationVCCode];
    BaseItem *item14 = [BaseItem baseItemWithTitle:@"基础动画" code:AnimationFromUIVCCode];
    BaseItem *item15 = [BaseItem baseItemWithTitle:@"UIView - 弹簧动画" code:SpringAnimationVCCode];
    BaseItem *item16 = [BaseItem baseItemWithTitle:@"UIView - 关键帧动画" code:KeyFrameUIAnimationVCCode];
    BaseItem *item17 = [BaseItem baseItemWithTitle:@"UIView - 转场动画" code:TransitionUIAnimationVCCode];
    
    NSArray *items = @[item1, item2, item3, item4, item5,
                       item6, item7, item8, item9, item10,
                       item11, item12, item13,item14, item15,
                       item16, item17];
    [self.datas addObjectsFromArray:items];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseItem *item = self.datas[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];

    cell.textLabel.text = item.title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseItem *item = self.datas[indexPath.row];
    
    if ([item.code isEqualToString:AnimateVCCode]) {
        AnimateViewController *animateVC = [[AnimateViewController alloc] init];
        [self.navigationController pushViewController:animateVC animated:YES];
    } else if ([item.code isEqualToString:LayerTransformVCCode]) {
        LayerTransformViewController *layerVC = [[LayerTransformViewController alloc] init];
        [self.navigationController pushViewController:layerVC animated:YES];
    } else if ([item.code isEqualToString:LayerAnimateVCCode]) {
        LayerAnimateViewController *layerVC = [[LayerAnimateViewController alloc] init];
        [self.navigationController pushViewController:layerVC animated:YES];
    } else if ([item.code isEqualToString:ActivityIndicatorVCCode]) {
        ActivityIndicatorViewController *vc = [[ActivityIndicatorViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:CALayerDefaultAnimationVCCode]) {
        CALayerDefaultAnimationVC *vc = [[CALayerDefaultAnimationVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:CALayerDrawInRectVCCode]) {
        CALayerDrawInRectViewController *vc = [[CALayerDrawInRectViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:CustomLayerDrawInRectVCCode]) {
        CustomLayerDrawInRectViewController *vc = [[CustomLayerDrawInRectViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:CoreAnimationVCCode]) {
        CoreAnimationViewController *vc = [[CoreAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:CoreAnimation2VCCode]) {
        CoreAnimation2ViewController *vc = [[CoreAnimation2ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:KeyFrameAnimationVCCode]) {
        KeyFrameAnimationViewController *vc = [[KeyFrameAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:AnimationGroupVCCode]) {
        AnimationGroupViewController *vc = [[AnimationGroupViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:TransitionAnimationVCCode]) {
        TransitionAnimationViewController *vc = [[TransitionAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:CADisplaylinkAnimationVCCode]) {
        CADisplaylinkAnimationViewController *vc = [[CADisplaylinkAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:AnimationFromUIVCCode]) {
        AnimationFromUIViewController *vc = [[AnimationFromUIViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:SpringAnimationVCCode]) {
        SpringAnimationViewController *vc = [[SpringAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:KeyFrameUIAnimationVCCode]) {
        KeyFrameUIAnimationViewController *vc = [[KeyFrameUIAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.code isEqualToString:TransitionUIAnimationVCCode]) {
        TransitionUIAnimationViewController *vc = [[TransitionUIAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - lazy

- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}

@end
