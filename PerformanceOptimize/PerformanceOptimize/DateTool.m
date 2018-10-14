//
//  DateTool.m
//  PerformanceOptimize
//
//  Created by chenshuang on 2018/10/14.
//  Copyright © 2018年 wenwen. All rights reserved.
//

#import "DateTool.h"
#include <time.h>

@implementation DateTool

+ (NSDateFormatter *)cachedDateFormatter {
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:@"cachedDateFormatter"];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat: @"YYYY-MM-dd HH:mm:ss"];
        [threadDictionary setObject:dateFormatter forKey:@"cachedDateFormatter"];
    }
    return dateFormatter;
}

+ (NSDate *)easyDateFormatter{
    time_t t;
    struct tm tm;
    char *iso8601 = "2016-09-18";
    strptime(iso8601, "%Y-%m-%d", &tm);
    
    tm.tm_isdst = -1;
    tm.tm_hour = 0;//当tm结构体中的tm.tm_hour为负数，会导致mktime(&tm)计算错误
    
    /**
     //NSString *iso8601String = @"2016-09-18T17:30:08+08:00";
     //%Y-%m-%d [iso8601String cStringUsingEncoding:NSUTF8StringEncoding]
     
     {
         tm_sec = 0
         tm_min = 0
         tm_hour = 0
         tm_mday = 18
         tm_mon = 9
         tm_year = 116
         tm_wday = 2
         tm_yday = 291
         tm_isdst = 0
         tm_gmtoff = 28800
         tm_zone = 0x00007fd9b600c31c "CST"
     }
     ISO8601时间格式：2004-05-03T17:30:08+08:00 参考Wikipedia
     */
    
    t = mktime(&tm);
    
    //http://pubs.opengroup.org/onlinepubs/9699919799/functions/mktime.html
    //secondsFromGMT: The current difference in seconds between the receiver and Greenwich Mean Time.
    
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}

@end
