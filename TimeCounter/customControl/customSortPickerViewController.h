//
//  customSortPickerViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/5/1.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

enum
{
    sortTypeIndexCategory = 0,
    sortTypeIndexDate = 1,
};
typedef NSUInteger sortTypeIndex;

@class customSortPickerViewController;
@protocol sortPickerDelegate <NSObject>

- (void)sortPickerView:(customSortPickerViewController*)view didPickSortWithType:(NSString*)sortType andSortTypeIndex:(sortTypeIndex)sortInd;

@end

@interface customSortPickerViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    id<sortPickerDelegate> delegate;
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIPickerView *sortPicker;
    NSArray *sortTypeArray;
    NSString *currentSortType;
}

@property (assign) id<sortPickerDelegate> delegate;
@property (nonatomic, retain) NSString *currentSortType;

@end
