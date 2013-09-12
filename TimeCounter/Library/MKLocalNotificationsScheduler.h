//
//  MKLocalNotificationsScheduler.h
//  LocalNotifs
//
//  Created by Mugunth Kumar on 9-Aug-10.
//  Copyright 2010 Steinlogic. All rights reserved.
//	File created using Singleton XCode Template by Mugunth Kumar (http://mugunthkumar.com
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import <Foundation/Foundation.h>
#import "DateFunction.h"

@interface MKLocalNotificationsScheduler : NSObject 

+ (void) scheduleNotificationOn:(NSDate*)fireDate endReminderDate:(NSDate*)endDate repeatInterval:(NSInteger)unit text:(NSString*)alertText action:(NSString*)alertAction sound:(NSString*)soundfileName launchImage:(NSString*)launchImage  andInfo:(NSDictionary*)userInfo delayUnit:(NSInteger)unit;

+ (void) cancelNotificationOn:(NSDate*)fireDate endReminderDate:(NSDate*)endDate repeatInterval:(NSInteger)unit text:(NSString*)alertText action:(NSString*)alertAction sound:(NSString*)soundfileName launchImage:(NSString*)launchImage  andInfo:(NSDictionary*)userInfo delayUnit:(NSInteger)unit;


@end
