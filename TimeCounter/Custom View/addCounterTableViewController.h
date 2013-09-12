//
//  addCounterTableViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/3/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalFunctions.h"
#import "timeCounterInfo.h"
#import "customPictureCell.h"
#import "infoPanel.h"
#import "MyDateTimePickerViewController.h"
#import "customCategoryPickViewController.h"
#import "customNotifyCell.h"
#import "customRepeatPickViewController.h"

enum
{
    addViewGroupOptionPicture = 0,
    addViewGroupOptionDescription = 1
};
typedef NSUInteger addViewGroupOption;

enum
{
    choosePictureSourseTypeCamera = 0,
    choosePictureSourseTypeLibrary = 1,
};
typedef NSUInteger choosePictureSourseType;

enum
{
    pictureGroupTypePicture = 0,
    pictureGroupTypeStartDate = 1,
    pictureGroupTypeEndDate = 2,
    pictureGroupTypeNotify = 3,
};
typedef NSUInteger pictureGroupType;

enum
{
    descriptionGorupTypeClass = 0,
    descriptionGorupTypeIntro = 1,
};
typedef NSUInteger descriptionGorupType;

@class addCounterTableViewController;
@protocol addCounterDelegate <NSObject>

@required
- (void)addCounterView:(addCounterTableViewController*)view didAddRecord:(timeCounterInfo*)info;
- (void)addCounterView:(addCounterTableViewController*)view didModify:(timeCounterInfo*)info andRow:(NSUInteger)row andCategory:(NSString*)category andDateString:(NSString*)dateString;
- (void)addCounterView:(addCounterTableViewController *)view didModifyWithoutModify:(timeCounterInfo *)info;

@end

@interface addCounterTableViewController : UITableViewController
<pictureCellDelegate, UINavigationControllerDelegate, 
UIImagePickerControllerDelegate, UIActionSheetDelegate,UITextFieldDelegate,
MyDateTimePickerDelegate, classPickerDelegate, notifyCellDelegate, releatPickerDelegate>
{
    id<addCounterDelegate> delegate;
    NSArray *functionArray;
    NSArray *pictureGroup;
    NSArray *introGroup;
    timeCounterInfo *newInfo;
    timeCounterInfo *currentInfo;
    /*
     修改時的參數
     */
    BOOL isModify;
    NSUInteger modifyRow;
    NSString *modifyDateString;
    NSString *modifyCategory;
}
@property (assign) id<addCounterDelegate> delegate;
@property (nonatomic, retain) timeCounterInfo *currentInfo;
@property (nonatomic) BOOL isModify;
@property (nonatomic) NSUInteger modifyRow;
@property (nonatomic, retain) NSString *modifyCategory;
@property (nonatomic, retain) NSString *modifyDateString;

@end
