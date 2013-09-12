//
//  customCategoryHandleTableViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/5/8.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addCategoryViewController.h"

@interface customCategoryHandleTableViewController : UITableViewController <addCategoryDelegate>
{
    NSMutableArray *categoryArray;
}

@end
