//
//  GlobalFunctions.h
//  ClockReminder
//
//  Created by 張星星 on 11/12/16.
//  Copyright (c) 2011年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateFunction.h"
#import "ProcessImage.h"
#import "UIImage+Resize.h"

@interface GlobalFunctions : NSObject

+(GlobalFunctions*)shareInstance;

- (NSString*)getDocumentFullPath:(NSString*)fileName;
- (NSString*)getTempDirectoryFullPath:(NSString*)fileName;
- (NSInteger)currentLanguageInd;
- (void)saveAppInfoWithKey:(NSString*)key andValue:(NSString*)value;
- (NSString*)getAppInfoWithKey:(NSString*)key;
- (NSArray*)getCategoryArray;
- (void)saveCategoryArray:(NSArray*)categoryArray;
- (NSString*)getNewSerial;
- (void)saveNewSerial:(NSInteger)serial;
- (void)saveSyncronizedWithKey:(NSString*)key andValue:(NSString*)value;
- (NSString*)getSyncronizedValueWithKey:(NSString *)key;
- (NSString*)getRepeatTypeName:(NSInteger)type;
@end
