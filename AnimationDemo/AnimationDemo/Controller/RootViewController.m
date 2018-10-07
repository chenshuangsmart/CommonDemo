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

static NSString *CellID = @"CellID";
static NSString *AnimateVCCode = @"AnimateVCCode";
static NSString *LayerTransformVCCode = @"LayerTransformVCCode";
static NSString *LayerAnimateVCCode = @"LayerAnimateVCCode";
static NSString *ActivityIndicatorVCCode = @"ActivityIndicatorVCCode";

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
    
    NSArray *items = @[item1, item2, item3, item4];
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
