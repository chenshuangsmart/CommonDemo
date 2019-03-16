//
//  ViewController.m
//  0317
//
//  Created by cs on 2019/3/16.
//  Copyright © 2019 cs. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *dataSources;
/** count */
@property(nonatomic, assign)NSUInteger count;
@end

@implementation ViewController {
    UILabel *_fpsLbe;
    
    CADisplayLink *_link;
    NSTimeInterval _lastTime;
    float _fps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupData];
    // drawUI
    [self drawUI];
    // start
    [self startMonitoring];
    // 法二
    //    [self startFpsMonitoring];
    // add observer
    [self addObserver];
}

- (void)setupData {
    for (int i = 0; i < 1000; i++) {
        NSString *title = [NSString stringWithFormat:@"indexPath: %d",i];
        [self.dataSources addObject:title];
    }
}

- (void)drawUI {
    // info
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 44)];
    infoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:infoView];
    
    _fpsLbe = [[UILabel alloc] initWithFrame:infoView.bounds];
    _fpsLbe.textColor = [UIColor blackColor];
    _fpsLbe.textAlignment = NSTextAlignmentCenter;
    _fpsLbe.text = @"FPS:60";
    [infoView addSubview:_fpsLbe];
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.dataSources objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    float posX = 10;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 5, 40, 40)];
    imgView.image = [UIImage imageNamed:@"cloth"];
    imgView.layer.cornerRadius = 20;
    imgView.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgView];
    posX = 70;
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 5, 40, 40)];
    imgView2.image = [UIImage imageNamed:@"img1"];
    imgView2.layer.cornerRadius = 20;
    imgView2.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgView2];
    posX = 130;
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 5, 40, 40)];
    imgView3.image = [UIImage imageNamed:@"img2"];
    imgView3.layer.cornerRadius = 20;
    imgView3.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgView3];
    posX = 190;
    
    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 5, 40, 40)];
    imgView4.image = [UIImage imageNamed:@"img3"];
    imgView4.layer.cornerRadius = 20;
    imgView4.layer.masksToBounds = YES;
    [cell.contentView addSubview:imgView4];
    posX = 250;
    
    UILabel *lbe = [[UILabel alloc] initWithFrame:CGRectMake(posX, 10, 0, 0)];
    lbe.text = title;
    [lbe sizeToFit];
    [cell.contentView addSubview:lbe];
    
    return cell;
}

#pragma mark - FPS

- (void)startMonitoring {
    if (_link) {
        [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [_link invalidate];
        _link = nil;
    }
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsDisplayLinkAction:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)fpsDisplayLinkAction:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    self.count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    
    _lastTime = link.timestamp;
    _fps = _count / delta;
    NSLog(@"count = %d, delta = %f,_lastTime = %f, _fps = %.0f",_count, delta, _lastTime, _fps);
    self.count = 0;
    _fpsLbe.text = [NSString stringWithFormat:@"FPS:%.0f",_fps];
}

#pragma mark - 法二

- (void)startFpsMonitoring {
    _link = [CADisplayLink displayLinkWithTarget: self selector: @selector(displayFps:)];
    [_link addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
}

- (void)displayFps: (CADisplayLink *)fpsDisplay {
    self.count++;
    CFAbsoluteTime threshold = CFAbsoluteTimeGetCurrent() - _lastTime;
    if (threshold >= 1.0) {
        _fps = (_count / threshold);
        _lastTime = CFAbsoluteTimeGetCurrent();
        _fpsLbe.text = [NSString stringWithFormat:@"FPS:%.0f",_fps];
        self.count = 0;
        NSLog(@"count = %d,_lastTime = %f, _fps = %.0f",_count, _lastTime, _fps);
    }
}

#pragma mark - observer

- (void)addObserver {
    [self addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"count new = %@, old = %@",[change valueForKey:@"new"], [change valueForKey:@"old"]);
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, ScreenWidth, ScreenHeight - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = true;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 50;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    }
    return _tableView;
}

- (NSMutableArray *)dataSources {
    if (_dataSources == nil) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}


@end
