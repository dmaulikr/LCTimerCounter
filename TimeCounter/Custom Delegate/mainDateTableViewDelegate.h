//
//  mainDateTableViewDelegate.h
//  TimeCounter
//
//  Created by 張星星 on 12/4/30.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "customTimerCell.h"
#import "timeCounterInfo.h"

@class mainDateTableViewDelegate;
@protocol dateTableViewDelegate <NSObject>

- (void)dateTableView:(mainDateTableViewDelegate*)view didSelectTableViewCellAtIndex:(NSIndexPath*)indexPath;
- (void)dateTableView:(mainDateTableViewDelegate*)view didDeleteTableViewCellAtIndex:(NSIndexPath*)indexPath;

@end

@interface mainDateTableViewDelegate : NSObject
<UITableViewDelegate , UITableViewDataSource>
{
    id<dateTableViewDelegate> delegate;
    NSArray *dateGroupArray;
    NSArray *timerArray;
}

@property (assign) id<dateTableViewDelegate> delegate;
@property (nonatomic, retain) NSArray *dateGroupArray;
@property (nonatomic, retain) NSArray *timerArray;

@end
