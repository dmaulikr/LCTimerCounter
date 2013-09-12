//
//  addCategoryViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/5/9.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "addCategoryViewController.h"

@interface addCategoryViewController ()

- (void)createToolBarItem;
- (void)backItemPress;
- (void)confirmItemPress;

@end

@implementation addCategoryViewController
@synthesize delegate;
@synthesize currentCategoryName;
@synthesize modifyIndexPath, isModify;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createToolBarItem];
    [textView setDelegate:self];
    [textView setInputAccessoryView:toolBar];
    [textView becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (currentCategoryName != nil)
    {
        [textView setText:currentCategoryName];
    }
}

- (void)dealloc
{
    [super dealloc];
    delegate = nil;
    [textView release];
    [toolBar release];
    [currentCategoryName release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)createToolBarItem
{
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Done", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(confirmItemPress)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Back", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(confirmItemPress)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *items = [[NSArray alloc] initWithObjects:confirmItem, flexItem, backItem, nil];
    [toolBar setItems:items];
    [confirmItem release];
    [backItem release];
    [flexItem release];
    [items release];
}
- (void)backItemPress
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)confirmItemPress
{
    [self dismissModalViewControllerAnimated:YES];
    if (isModify)
    {
        [delegate addCategoryView:self didModifyCategory:[NSString stringWithFormat:@"%@",[textView text]] andIndexPath:modifyIndexPath];
    }
    else
    {
        [delegate addCategoryView:self didAddCategory:[NSString stringWithFormat:@"%@",[textView text]]];
    }
}

@end
