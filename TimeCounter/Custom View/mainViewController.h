//
//  mainViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/4/12.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addCounterTableViewController.h"
#import "CustomSearchBar.h"
#import "mainCategoryTableViewDelegate.h"
#import "mainDateTableViewDelegate.h"
#import "settingTableViewController.h"
#import "customCategoryPickViewController.h"

@interface mainViewController : UIViewController
<addCounterDelegate, UISearchBarDelegate, 
categoryTableViewDelegate, dateTableViewDelegate, 
classPickerDelegate>
{
    IBOutlet UITableView *mainTableView;
    CustomSearchBar *searchBar;
    NSMutableArray *timerArray;
    NSArray *categoryArray;
    NSArray *dateGroupArray;
    NSArray *allArray;
    NSArray *searchResultArray;
    mainCategoryTableViewDelegate *categoryDelegate;
    mainDateTableViewDelegate *dateDelegate;
    //設定相關資訊
    NSString *sortType;
    NSInteger searchCategory;
    NSString *searchKey;
}

- (void)addButtonPress:(id)sender;
- (IBAction)showToolBarPress:(id)sender;
@end
