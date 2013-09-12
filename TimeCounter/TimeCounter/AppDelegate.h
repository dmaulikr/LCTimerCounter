//
//  AppDelegate.h
//  TimeCounter
//
//  Created by 張星星 on 12/3/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainTableViewController.h"
#import "mainViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *nav;
    //mainTableViewController *view;
    mainViewController *view;
}

@property (strong, nonatomic) UIWindow *window;

- (void)initSystemInfomation;

@end
