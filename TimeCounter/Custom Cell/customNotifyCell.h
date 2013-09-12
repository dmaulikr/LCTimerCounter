//
//  customNotifyCell.h
//  TimeCounter
//
//  Created by 張星星 on 12/5/3.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class customNotifyCell;
@protocol notifyCellDelegate <NSObject>

- (void)notifyCell:(customNotifyCell*)cell didNotifySwitchChange:(BOOL)value;

@end

@interface customNotifyCell : UITableViewCell
{
    id<notifyCellDelegate> delegate;
    UISwitch *notifySwitch;
    UILabel *titleLabel;
}

@property (assign) id<notifyCellDelegate> delegate;
@property (nonatomic, retain) IBOutlet UISwitch *notifySwitch;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;

- (IBAction)notifySwitchValueChange:(id)sender;

@end
