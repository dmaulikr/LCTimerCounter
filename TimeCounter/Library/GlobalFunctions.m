//
//  GlobalFunctions.m
//  ClockReminder
//
//  Created by 張星星 on 11/12/16.
//  Copyright (c) 2011年 星星. All rights reserved.
//

#import "GlobalFunctions.h"
static GlobalFunctions *_instance;
@implementation GlobalFunctions

#pragma mark - UserDefaults

+ (GlobalFunctions*)shareInstance
{
    @synchronized(self)
    {
        if (_instance == nil)
        {
            //iOS4 compatibility check
            Class notificationClass = NSClassFromString(@"GlobalFunctions");
            if (notificationClass == nil)
            {
                return _instance = nil;
            }
            else
            {
                _instance = [[super allocWithZone:NULL] init];
            }
        }
    }
    return _instance;
}

- (NSString*)getDocumentFullPath:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullName = [documentsDirectory stringByAppendingPathComponent:fileName];
    return fullName;
}
- (NSString*)getTempDirectoryFullPath:(NSString*)fileName
{
    NSString *tempDirectory = NSTemporaryDirectory();
    NSString *fullPath = [tempDirectory stringByAppendingPathComponent:fileName];
    return fullPath;
}
- (void)saveAppInfoWithKey:(NSString*)key andValue:(NSString*)value
{
    NSString *appInfoPath = [self getDocumentFullPath:@"appInfo.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:appInfoPath])
    {
        //NSString *appInfoBundle = [[NSBundle mainBundle] pathForResource:@"appInfo" ofType:@"plist"];
        //if (![[NSFileManager defaultManager] copyItemAtPath:appInfoBundle toPath:appInfoPath error:nil])
            //NSLog(@"Copy appInfo faild");
        NSDictionary *dictionAry = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    @"Reachable", @"KaxaNetReachStatus",
                                    @"serial",@"0",nil];
        [dictionAry writeToFile:appInfoPath atomically:YES];
    }
    NSMutableDictionary *appInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:appInfoPath];
    [appInfo setValue:value forKey:key];
    if (![appInfo writeToFile:appInfoPath atomically:YES])
        NSLog(@"Save appInfo feild");
}
- (NSString*)getAppInfoWithKey:(NSString*)key
{
    NSString *appInfoPath = [self getDocumentFullPath:@"appInfo.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:appInfoPath])
    {
        //NSString *appInfoBundle = [[NSBundle mainBundle] pathForResource:@"appInfo" ofType:@"plist"];
        //if (![[NSFileManager defaultManager] copyItemAtPath:appInfoBundle toPath:appInfoPath error:nil])
        //    NSLog(@"Copy appInfo faild");
        NSDictionary *dictionAry = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    @"Reachable", @"KaxaNetReachStatus",
                                    @"serial", @"0", nil];
        [dictionAry writeToFile:appInfoPath atomically:YES];
    }
    NSDictionary *appInfo = [[NSDictionary alloc] initWithContentsOfFile:appInfoPath];
    return [appInfo valueForKey:key];
}
- (NSArray*)getCategoryArray
{
    NSArray *classArray;
    NSString *categoryPath = [[GlobalFunctions shareInstance] getDocumentFullPath:@"category.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:categoryPath])
    {
        NSDictionary *category = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"category" ofType:@"plist"]];
        [category writeToFile:categoryPath atomically:YES];
        [category release];
    }
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:categoryPath];
    if ([[GlobalFunctions shareInstance] currentLanguageInd] == 0)
        classArray = [NSArray arrayWithArray:[dict valueForKey:@"category_tw"]];
    else
        classArray = [NSArray arrayWithArray:[dict valueForKey:@"category_en"]];
    [dict release];
    return classArray;
}
- (void)saveCategoryArray:(NSArray*)categoryArray
{
    NSString *categoryPath = [[GlobalFunctions shareInstance] getDocumentFullPath:@"category.plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:categoryPath];
    if ([[GlobalFunctions shareInstance] currentLanguageInd] == 0)
    {
        [dict setObject:categoryArray forKey:@"category_tw"];
    }
    else
    {
        [dict setObject:categoryArray forKey:@"category_en"];
    }
    [dict writeToFile:categoryPath atomically:YES];
    [dict release];
}
#pragma mark get / save serial (流水號的處理)
- (NSString*)getNewSerial
{
    NSInteger serial = [[self getAppInfoWithKey:@"serial"] integerValue];
    serial ++;
    return [[NSString alloc] initWithFormat:@"%i",serial];
}
- (void)saveNewSerial:(NSInteger)serial
{
    [self saveAppInfoWithKey:@"serial" andValue:[NSString stringWithFormat:@"%i",serial]];
}


- (NSInteger)currentLanguageInd
{
    //zh-Hant  繁體中文
    //zh-Hans  簡體中文
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language isEqualToString:@"zh-Hant"])
    {
        return 0;
    }
    else
    {
        return 1;
    }
    NSLog(@"%@",language);
}
- (void)saveSyncronizedWithKey:(NSString *)key andValue:(NSString *)value
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString*)getSyncronizedValueWithKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
- (NSString*)getRepeatTypeName:(NSInteger)type
{
    NSString *desc;
    switch (type)
    {
        case 0:
            desc = [NSString stringWithFormat:@"每天"];
            break;
        case 1:
            desc = [NSString stringWithFormat:@"每週"];
            break;
        default:
            desc = [NSString stringWithFormat:@"每天"];
            break;
    }
    return desc;
}
@end
