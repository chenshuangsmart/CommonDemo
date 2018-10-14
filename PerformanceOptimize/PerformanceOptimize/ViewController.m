//
//  ViewController.m
//  PerformanceOptimize
//
//  Created by chenshuang on 2018/10/14.
//  Copyright © 2018年 wenwen. All rights reserved.
//

#import "ViewController.h"
#import "DateTool.h"
#import <sqlite3.h>
#import <sys/stat.h>

#ifdef DEBUG
// Only log when attached to the debugger
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...) /* */
#endif
// Always log, even in production
#define ALog(...) NSLog(__VA_ARGS__)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1.获取当前时间
//    [self getCurTime];
    
    // 2.striptime测试
//    [self strpTimeTest];
    
    // 1.4 NSFileManager测试
//    [self fileManagerTest];
    
    // 1.6 stringWithFormat提升
    [self stringWithFormatTest];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *time1 = [self getCurTime];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *time2 = [self getCurTime];
        [self pleaseInsertStarTimeo:time1 andInsertEndTime:time2];
    });
}

// 1.1 NSDateFormatter缓存
- (NSString *)getCurTime {
    NSDateFormatter *dateFormatter = [DateTool cachedDateFormatter];
    NSDate* now = [NSDate date];
    NSString* dateString = [dateFormatter stringFromDate:now];
    return dateString;
}

- (void)pleaseInsertStarTimeo:(NSString *)time1 andInsertEndTime:(NSString *)time2{
    // 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    
    // 4.输出结果
    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
}

// 1.2 striptime测试
- (void)strpTimeTest {
    NSDate *date = [DateTool easyDateFormatter];
    NSDateFormatter *dateFormatter = [DateTool cachedDateFormatter];
    NSString* dateString = [dateFormatter stringFromDate:date];
    NSLog(@"dateString = %@",dateString);
}

// 1.3 sqlite3 测试
- (void)sqlite3Test {
    sqlite3 *db = NULL;
    NSString *iso8601String = @"2016-09-18";
    
    sqlite3_open(":memory:", &db);
    sqlite3_stmt *statement = NULL;
    sqlite3_prepare_v2(db, "SELECT strftime('%s', ?);", -1, &statement, NULL);
    sqlite3_bind_text(statement, 1, [iso8601String UTF8String], -1, SQLITE_STATIC);
    sqlite3_step(statement);
    int64_t value = sqlite3_column_int64(statement, 0);
    sqlite3_clear_bindings(statement);
    sqlite3_reset(statement);
}

// 1.4 NSFileManager
- (void)fileManagerTest {
    struct stat statbuf;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"money" ofType:@"txt"];
    const char *cpath = [filePath fileSystemRepresentation];
    if (cpath && stat(cpath, &statbuf) == 0) {
        NSNumber *fileSize = [NSNumber numberWithUnsignedLongLong:statbuf.st_size];
        NSDate *modificationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_mtime];
        NSDate *creationDate = [NSDate dateWithTimeIntervalSince1970:statbuf.st_ctime];
        // etc
        NSLog(@"fileSize = %@",fileSize);
        NSDateFormatter *dateFormatter = [DateTool cachedDateFormatter];
        NSString* modificationTime = [dateFormatter stringFromDate:modificationDate];
        NSString* creationTime = [dateFormatter stringFromDate:creationDate];
        NSLog(@"modificationTime = %@",modificationTime);
        NSLog(@"creationTime = %@",creationTime);
    }
}

// 1.6 stringWithFormat提升
- (void)stringWithFormatTest {
    NSString *firstName = @"Daniel";
    NSString *lastName = @"Amitay";
    
    char *buffer;
    asprintf(&buffer, "Full name: %s %s", [firstName UTF8String], [lastName UTF8String]);
    NSString *fullName = [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
    free(buffer);
    NSLog(@"fullName = %@",fullName);
}

- (void)viewText {
    UIView *redView = [[UIView alloc] init];
    redView.clearsContextBeforeDrawing = YES;
}

- (void)layerTest {
    CALayer *layer = [[CALayer alloc] init];
    layer.allowsGroupOpacity = YES;
    layer.drawsAsynchronously = YES;
    
    layer.shouldRasterize = YES;
    layer.shadowOpacity = 0.5f;
    layer.shadowRadius = 10.0f;
    layer.shadowOffset = CGSizeMake(0.0f, 10.0f);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:layer.bounds];
    layer.shadowPath = bezierPath.CGPath;
}

@end
