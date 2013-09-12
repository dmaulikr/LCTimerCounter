//
//  MKLocalNotificationsScheduler.m
//  LocalNotifs
//
//  Created by Mugunth Kumar on 9-Aug-10.
//  Copyright 2010 Steinlogic. All rights reserved.
//	File created using Singleton XCode Template by Mugunth Kumar (http://mugunthkumar.com
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import "MKLocalNotificationsScheduler.h"

@implementation MKLocalNotificationsScheduler

#pragma mark Singleton Methods


+ (void) scheduleNotificationOn:(NSDate*)fireDate endReminderDate:(NSDate*)endDate repeatInterval:(NSInteger)unit text:(NSString*)alertText action:(NSString*)alertAction sound:(NSString*)soundfileName launchImage:(NSString*)launchImage  andInfo:(NSDictionary*)userInfo delayUnit:(NSInteger)delayUnit
{
    NSInteger fireUnit;
    //取得年、月、曰
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    NSInteger unitFlags = NSYearCalendarUnit | 
    NSMonthCalendarUnit |
    NSDayCalendarUnit | 
    NSWeekdayCalendarUnit | 
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    if (unit == 0)
    {
        //每天
        fireUnit = 1;
    }
    else if (unit == 1)
    {
        //每週
        fireUnit = 7;
    }
    comps = [calendar components:unitFlags fromDate:fireDate];
    int year=[comps year];       //年
    int mon = [comps month];     //月
    int day = [comps day];       //曰
    int week = [comps weekday];      //週
    int hour = [comps hour];     //小時
    int min = [comps minute];    //分
    int sec = [comps second];    //秒
    NSLog(@"==========");
    NSLog(@"年:%i",year);
    NSLog(@"月:%i",mon);
    NSLog(@"週:%i",week);
    NSLog(@"曰:%i",day);
    NSLog(@"小時:%i",hour);
    NSLog(@"分:%i",min);
    NSLog(@"秒:%i",sec);
    NSLog(@"==========");
    /*
     1.不管如何，最後3天都要提醒
     2.超過7天則在依照每天或是每週註冊
     */
    for (int i = delayUnit ; i > 0; i--)
    {
        NSDate *regDate;
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        if (i == 1)
        {
            //前1天
            //regDate = fireDate1;
            regDate = [fireDate dateByAddingTimeInterval:-(60*60*24*1)];
        }
        else if (i == 2)
        {
            //前2天
            //regDate = fireDate2;
            regDate = [fireDate dateByAddingTimeInterval:-(60*60*24*1)];
        }
        else if (i == 3)
        {
            //前3天
            //regDate = fireDate3;
            regDate = [fireDate dateByAddingTimeInterval:-(60*60*24*1)];
        }
        else if (i > 3)
        {
            //判斷每週還是每年
            if (i % fireUnit == 0)
            {
                regDate = [fireDate dateByAddingTimeInterval:-(60*60*24*i)];
            }
            else 
            {
                continue;
            }
        }
        localNotification.alertBody = [NSString stringWithFormat:@"%@ 距離到期日還有%i天", alertText, i];
        NSTimeInterval timeIntervalSinceNow = [regDate timeIntervalSinceNow];
        if (timeIntervalSinceNow <= 0)
            return;
        localNotification.fireDate = regDate;
        localNotification.repeatInterval = 0;   //表示不重覆
        localNotification.timeZone = [NSTimeZone defaultTimeZone];	
        
        
        if(soundfileName == nil)
        {
            localNotification.soundName = UILocalNotificationDefaultSoundName;
        }
        else 
        {
            localNotification.soundName = soundfileName;
        }
        
        localNotification.applicationIconBadgeNumber = 1;			
        localNotification.userInfo = userInfo;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        [localNotification release];
    }
}

+ (void) cancelNotificationOn:(NSDate*)fireDate endReminderDate:(NSDate*)endDate repeatInterval:(NSInteger)unit text:(NSString*)alertText action:(NSString*)alertAction sound:(NSString*)soundfileName launchImage:(NSString*)launchImage  andInfo:(NSDictionary*)userInfo delayUnit:(NSInteger)delayUnit
{
    NSInteger fireUnit;
    //取得年、月、曰
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSCalendar *calendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *comps = [[[NSDateComponents alloc] init] autorelease];
    NSInteger unitFlags = NSYearCalendarUnit | 
    NSMonthCalendarUnit |
    NSDayCalendarUnit | 
    NSWeekdayCalendarUnit | 
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:fireDate];
    int year=[comps year];       //年
    int mon = [comps month];     //月
    int day = [comps day];       //曰
    int week = [comps weekday];      //週
    int hour = [comps hour];     //小時
    int min = [comps minute];    //分
    int sec = [comps second];    //秒
    NSLog(@"==========");
    NSLog(@"年:%i",year);
    NSLog(@"月:%i",mon);
    NSLog(@"週:%i",week);
    NSLog(@"曰:%i",day);
    NSLog(@"小時:%i",hour);
    NSLog(@"分:%i",min);
    NSLog(@"秒:%i",sec);
    NSLog(@"==========");
    if (unit == 0)
    {
        //每天
        fireUnit = 1;
    }
    else if (unit == 1)
    {
        //每週
        fireUnit = 7;
    }
    /*
     1.不管如何，最後3天都要提醒
     2.超過7天則在依照每天或是每週註冊
     */
    for (int i = delayUnit ; i > 0; i--)
    {
        NSDate *regDate;
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        if (i == 1)
        {
            //前1天
            //regDate = fireDate1;
            regDate = [fireDate dateByAddingTimeInterval:-(60*60*24*1)];
        }
        else if (i == 2)
        {
            //前2天
            //regDate = fireDate2;
            regDate = [fireDate dateByAddingTimeInterval:-(60*60*24*1)];
        }
        else if (i == 3)
        {
            //前3天
            //regDate = fireDate3;
            regDate = [fireDate dateByAddingTimeInterval:-(60*60*24*1)];
        }
        else if (i > 3)
        {
            //判斷每週還是每年
            if (i % fireUnit == 0)
            {
                regDate = [fireDate dateByAddingTimeInterval:-(60*60*24*i)];
            }
            else 
            {
                continue;
            }
        }
        localNotification.alertBody = [NSString stringWithFormat:@"%@ 距離到期日還有%i天", alertText, i];
        NSTimeInterval timeIntervalSinceNow = [regDate timeIntervalSinceNow];
        if (timeIntervalSinceNow <= 0)
            return;
        localNotification.fireDate = regDate;
        localNotification.repeatInterval = 0;   //表示不重覆
        localNotification.timeZone = [NSTimeZone defaultTimeZone];	
        
        if(soundfileName == nil)
        {
            localNotification.soundName = UILocalNotificationDefaultSoundName;
        }
        else 
        {
            localNotification.soundName = soundfileName;
        }
        
        localNotification.applicationIconBadgeNumber = 1;	
        localNotification.userInfo = userInfo;
        
        // Schedule it with the app
        [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
        [localNotification release];
    }	
}

@end
