//
//  DateFunction.h
//  TimeCounter
//
//  Created by 張星星 on 12/3/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFunction : NSObject

+ (NSString*)DateToString:(NSDate*) aDate;
+ (NSDate*)StringToDate:(NSString*) aString;
+ (NSString*)DateToString2:(NSDate*) aDate;
+ (NSDate*)StringToDate2:(NSString*) aString;
+ (NSString*)IntervalBetweenToday:(NSDate*)date1 andDate:(NSDate*)date2 andEndDate:(NSDate*)date3;
+ (NSString*)GetYearAndMonthWithDate:(NSString *)dateString;

@end
