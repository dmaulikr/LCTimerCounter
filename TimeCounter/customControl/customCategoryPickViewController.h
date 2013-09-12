//
//  customClassPickViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/4/25.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class customCategoryPickViewController;
@protocol classPickerDelegate <NSObject>

@required
- (void)classPickerView:(customCategoryPickViewController*)view didPickClass:(NSInteger)classInd andPickClassName:(NSString*)name;

@end

@interface customCategoryPickViewController : UIViewController <UIPickerViewDelegate>
{
    IBOutlet UIPickerView *classPicker;
    IBOutlet UIToolbar *toolbar;
    NSArray *classArray;
    NSString *currentCategory;
    id<classPickerDelegate> delegate;
}
@property (assign) id<classPickerDelegate> delegate;
@property (nonatomic, retain) NSString *currentCategory;


@end
