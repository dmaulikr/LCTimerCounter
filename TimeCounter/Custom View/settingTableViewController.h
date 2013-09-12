//
//  settingTableViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/5/1.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpViewController.h"
#import "ConfigViewController.h"
#import "AboutViewController.h"
#import "ReaderViewController.h"

enum
{
    functionTypeHelp = 0,
    functionTypeConfig = 1,
    functionTypeAbout = 2,
};
typedef NSUInteger functionType;

@interface settingTableViewController : UITableViewController <ReaderViewControllerDelegate>
{
    NSArray *functionArray;
}

@end
