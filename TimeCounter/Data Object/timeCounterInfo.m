//
//  timeCounterInfo.m
//  TimeCounter
//
//  Created by 張星星 on 12/3/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "timeCounterInfo.h"

@implementation timeCounterInfo

@synthesize seq,imageUrl,imageFilePath,category,categoryName,intro,createTime,expireTime,timeInterval, isNotify;
@synthesize notifyType, notifyDays;

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}
- (id)initWithNewInfo
{
    self = [super init];
    if (self)
    {
        //產生流水號
        seq = [[GlobalFunctions shareInstance] getNewSerial];
        NSLog(@"seq:%@",seq);
        category = [[NSString alloc] initWithFormat:@"0"];
        categoryName = NSLocalizedStringFromTable(@"None", @"InfoPlist", nil);
        //預設為現在時間
        createTime = [[NSString alloc] initWithFormat:@"%@",[DateFunction DateToString:[NSDate date]]];
        expireTime = [[NSString alloc] initWithFormat:@""];
        imageFilePath = [[NSString alloc] initWithFormat:@"none"];
        imageUrl = [[NSString alloc] initWithFormat:@""];
        timeInterval = [[NSString alloc] initWithFormat:NSLocalizedStringFromTable(@"totalDays3", @"InfoPlist", "共幾天"), 0];
        intro = [[NSString alloc] initWithFormat:@""];
        isNotify = YES;
        notifyType = [[NSString alloc] initWithFormat:@"0"];
        notifyDays = [[NSString alloc] initWithFormat:@"3"];
    }
    return self;
}

- (void)dealloc
{
    [seq release], seq = nil;
    [category release], category = nil;
    [categoryName release], categoryName = nil;
    [imageUrl release], imageUrl = nil;
    [imageFilePath release], imageFilePath = nil;
    [intro release], intro = nil;
    [createTime release], createTime = nil;
    [expireTime release], expireTime = nil;
    [timeInterval release], timeInterval = nil;
    [notifyType release], notifyType = nil;
    [notifyDays release], notifyDays = nil;
    [super dealloc];
}

- (NSDictionary*)createTimerWithDictionary
{
    NSString *isNotifyString;
    if (isNotify)
    {
        isNotifyString = [NSString stringWithFormat:@"YES"];
    }
    else 
    {
        isNotifyString = [NSString stringWithFormat:@"NO"];
    }
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          seq, seqKey,
                          imageUrl, imageUrlKey,
                          imageFilePath, imageFilePathKey,
                          category, categoryKey,
                          categoryName, categoryNameKey, 
                          intro, introKey, 
                          createTime, createTimeKey, 
                          expireTime, expireTimeKey, 
                          timeInterval, timeIntervalKey,
                          isNotifyString, isNotifyKey,
                          notifyType, notifyTypeKey,
                          notifyDays, notifyDaysKey,
                          nil];
    return dict;
}
- (timeCounterInfo*)createTimerWithInfo:(NSDictionary*)dict
{
    timeCounterInfo *info = [[timeCounterInfo alloc] init];
    [info setSeq:[dict valueForKey:seqKey]];
    [info setCategory:[dict valueForKey:categoryKey]];
    [info setCategoryName:[dict valueForKey:categoryNameKey]];
    [info setImageUrl:[dict valueForKey:imageUrlKey]];
    [info setImageFilePath:[dict valueForKey:imageFilePathKey]];
    [info setIntro:[dict valueForKey:introKey]];
    [info setCreateTime:[dict valueForKey:createTimeKey]];
    [info setExpireTime:[dict valueForKey:expireTimeKey]];
    [info setTimeInterval:[dict valueForKey:timeInterval]];
    NSString *isNotifyString = [dict valueForKey:isNotifyKey];
    [info setIsNotify:[isNotifyString boolValue]];
    [info setNotifyType:[dict valueForKey:notifyTypeKey]];
    [info setNotifyDays:[dict valueForKey:notifyDaysKey]];
    return info;
}

@end
