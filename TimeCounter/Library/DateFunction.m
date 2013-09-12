//
//  DateFunction.m
//  TimeCounter
//
//  Created by 張星星 on 12/3/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "DateFunction.h"

@implementation DateFunction

+ (NSString*)DateToString:(NSDate*) aDate
{
    if (aDate == nil)
        return @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:aDate];
    return strDate;
}
+ (NSDate*)StringToDate:(NSString*) aString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:aString];
    return date;
}
+ (NSString*)DateToString2:(NSDate*) aDate
{
    if (aDate == nil)
        return @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:aDate];
    return strDate;
}
+ (NSDate*)StringToDate2:(NSString*) aString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:aString];
    return date;
}

+ (NSString*)IntervalBetweenToday:(NSDate*)date1 andDate:(NSDate*)date2 andEndDate:(NSDate*)date3
{
    NSTimeInterval interval = [date1 timeIntervalSinceDate:date2];
    NSTimeInterval interval2 = [date3 timeIntervalSinceDate:date1];
    NSNumber *dayInterval =  [NSNumber numberWithDouble:(int)interval / (60 * 60 * 24)];
    NSNumber *dayLeft;
    if (date3 == nil)
        dayLeft = 0;
    else 
        dayLeft = [NSNumber numberWithDouble:(int)interval2 / (60*60*24)];
    NSString *intervalString;
    if ([dayLeft integerValue] > 0)
    {
        intervalString = [NSString stringWithFormat:NSLocalizedStringFromTable(@"totalDays1", @"InfoPlist", @"共幾天"), [dayInterval integerValue], [dayLeft integerValue]];
    }
    else if ([dayLeft integerValue] < 0)
    {
        intervalString = [NSString stringWithFormat:NSLocalizedStringFromTable(@"totalDays2", @"InfoPlist", @"共幾天"), [dayInterval integerValue], [dayLeft integerValue]];
    }
    else 
    {
        intervalString = [NSString stringWithFormat:NSLocalizedStringFromTable(@"totalDays3", @"InfoPlist", @"共幾天"), [dayInterval integerValue]];
    }
    NSLog(@"interval-->%@, %f",intervalString, interval);
    return intervalString;
}
+ (NSString*)GetYearAndMonthWithDate:(NSString *)dateString
{
    NSDate *aDate = [self StringToDate:dateString];
    //取得年、月、曰
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    NSInteger unitFlags = NSYearCalendarUnit | 
    NSMonthCalendarUnit |
    NSDayCalendarUnit | 
    NSWeekdayCalendarUnit | 
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:aDate];
    NSInteger year =[comps year];       //年
    NSInteger mon = [comps month];     //月
    NSString *yearMonString = [NSString stringWithFormat:@"%02i-%02i",year,mon];
    return yearMonString;
}
@end
