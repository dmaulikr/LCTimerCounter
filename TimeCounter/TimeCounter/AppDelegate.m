//
//  AppDelegate.m
//  TimeCounter
//
//  Created by 張星星 on 12/3/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalFunctions.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [nav release], nav = nil;
    [view release], view = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    view = [[mainViewController alloc] initWithNibName:@"mainViewController" bundle:nil];
    nav = [[UINavigationController alloc] initWithRootViewController:view];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    //初始化系統
    [self initSystemInfomation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initSystemInfomation
{
    if ([[GlobalFunctions shareInstance] getSyncronizedValueWithKey:@"initTimeCounter"] == nil)
    {
        [[GlobalFunctions shareInstance] saveSyncronizedWithKey:sortTypeKey andValue:sortByCategory];
        [[GlobalFunctions shareInstance] saveSyncronizedWithKey:@"initTimeCounter" andValue:@"1"];
    }
}

@end
