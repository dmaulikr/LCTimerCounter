//
//  ConfigViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/5/6.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigViewController.h"
#import "customCategoryHandleTableViewController.h"
#import "customSortPickerViewController.h"

enum 
{
    configFunctionTypeCategory = 0,
    configFunctionTypeSort = 1,
};
typedef NSUInteger configFunctionType;

@interface ConfigViewController : UITableViewController <sortPickerDelegate>
{
    NSArray *functionArray;
}
@end
