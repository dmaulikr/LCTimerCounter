//
//  customTimerCell.h
//  TimeCounter
//
//  Created by 張星星 on 12/4/26.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTimerCell : UITableViewCell
{
    UILabel *categoryLabel;
    UILabel *startDateLabel;
    UILabel *endDateLabel;
    UILabel *descriptionLabel;
    UILabel *daysLabel;
    UILabel *timeIntervalLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *categoryLabel;
@property (nonatomic, retain) IBOutlet UILabel *startDateLabel;
@property (nonatomic, retain) IBOutlet UILabel *endDateLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *daysLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeIntervalLabel;

@end
