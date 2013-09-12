//
//  mainCategoryTableViewDelegate.h
//  TimeCounter
//
//  Created by 張星星 on 12/4/30.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "customTimerCell.h"
#import "timeCounterInfo.h"

@class mainCategoryTableViewDelegate;
@protocol categoryTableViewDelegate <NSObject>

- (void)categoryTableView:(mainCategoryTableViewDelegate*)view didSelectTableViewAtIndexPath:(NSIndexPath*)indexPath;
- (void)categoryTableView:(mainCategoryTableViewDelegate*)view didDeleteTableViewAtIndexPath:(NSIndexPath*)indexPath;
@end

@interface mainCategoryTableViewDelegate : NSObject
<UITableViewDelegate, UITableViewDataSource>
{
    id<categoryTableViewDelegate> delegate;
    NSMutableArray *timerArray;
    NSArray *categoryArray;
}

@property (assign) id<categoryTableViewDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *timerArray;
@property (nonatomic, retain) NSArray *categoryArray;

@end
