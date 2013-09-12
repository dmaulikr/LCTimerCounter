//
//  customRepeatPickViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/5/10.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

enum
{
    repeatPickerComponentType = 0,
    repeatPickerComponentDays = 1,
};
typedef NSUInteger repeatPickerComponent;

@class customRepeatPickViewController;
@protocol releatPickerDelegate <NSObject>

- (void)repeatPickerView:(customRepeatPickViewController*)view didPickRepeatType:(NSUInteger)unit andDays:(NSUInteger)days;

@end

@interface customRepeatPickViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    id<releatPickerDelegate> delegate;
    NSArray *repeatTypeArray;
    NSArray *daysArray;
    IBOutlet UIPickerView *repeatPicker;
    IBOutlet UIToolbar *toolbar;
    NSInteger notifyType;
    NSInteger notifyDays;
}

@property (assign) id<releatPickerDelegate> delegate;
@property (nonatomic) NSInteger notifyType;
@property (nonatomic) NSInteger notifyDays;

@end
