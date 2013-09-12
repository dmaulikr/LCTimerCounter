//
//  timeCounterInfo.h
//  TimeCounter
//
//  Created by 張星星 on 12/3/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalFunctions.h"

#define seqKey @"seq"
#define imageUrlKey @"imageUrl"
#define imageFilePathKey @"imageFilePath"
#define categoryKey @"category"
#define categoryNameKey @"categoryNameKey"
#define introKey @"intro"
#define createTimeKey @"createTime"
#define expireTimeKey @"expireTime"
#define timeIntervalKey @"timeInterval"
#define isNotifyKey @"isNotify"
#define notifyTypeKey @"notifyType"
#define notifyDaysKey @"notifyDays"

@interface timeCounterInfo : NSObject
{
    NSString *seq;
    NSString *imageUrl;
    NSString *imageFilePath;
    NSString *category;
    NSString *categoryName;
    NSString *intro;
    NSString *createTime;
    NSString *expireTime;
    NSString *timeInterval;
    BOOL isNotify;
    NSString *notifyType;
    NSString *notifyDays;
}
@property (nonatomic, retain) NSString *seq;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *imageFilePath;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSString *intro;
@property (nonatomic, retain) NSString *createTime;
@property (nonatomic, retain) NSString *expireTime;
@property (nonatomic, retain) NSString *timeInterval;
@property (nonatomic) BOOL isNotify;
@property (nonatomic, retain) NSString *notifyType;
@property (nonatomic, retain) NSString *notifyDays;

- (id)initWithNewInfo;

/*
 儲存檔案時的轉換
 */
- (NSDictionary*)createTimerWithDictionary;
- (timeCounterInfo*)createTimerWithInfo:(NSDictionary*)dict;

@end
