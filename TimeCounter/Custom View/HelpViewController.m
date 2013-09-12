//
//  HelpViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/5/6.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "HelpViewController.h"
#import "GlobalFunctions.h"

@interface HelpViewController ()

- (void)createBarItem;
- (void)backItemPress;

- (void)openHelpDocument;

@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = NSLocalizedStringFromTable(@"help", @"InfoString", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarItem];
    [self openHelpDocument];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - user define function

- (void)createBarItem
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"回主畫面" style:UIBarButtonItemStylePlain target:self action:@selector(backItemPress)];
    self.navigationItem.rightBarButtonItem = backItem;
}

- (void)backItemPress
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)openHelpDocument
{
    NSString *filePath;
    NSURL *url;
    if ([[GlobalFunctions shareInstance] currentLanguageInd] == 0)
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"張星星-2012-4-19" ofType:@"pdf"];
    }
    else if ([[GlobalFunctions shareInstance] currentLanguageInd] == 1)
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"張星星-2012-4-19" ofType:@"pdf"];
    }
    url = [NSURL fileURLWithPath:filePath];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}
@end
