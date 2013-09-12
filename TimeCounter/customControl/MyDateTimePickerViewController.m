//
//  MyDateTimePickerViewController.m
//  ClockReminder
//
//  Created by 張星星 on 11/12/16.
//  Copyright (c) 2011年 星星. All rights reserved.
//

#import "MyDateTimePickerViewController.h"

@interface MyDateTimePickerViewController()

- (void)createBarItem;
/*
 barItem 事件
 */
- (void)pressSelectButton:(id)sender;
- (void)pressCancelButton:(id)sender;
- (void)pressClearButton:(id)sender;

@end

@implementation MyDateTimePickerViewController

@synthesize delegate;
@synthesize currentReminderDate;
@synthesize cellRow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)dealloc
{
    [datePicker release], datePicker = nil;
    [currentReminderDate release], currentReminderDate = nil;
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarItem];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (currentReminderDate != nil)
        [datePicker setDate:currentReminderDate];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    datePicker = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - user define functions
- (void)pressSelectButton:(id)sender
{
    [delegate MyDateTimePickerViewController:self didPressButtonIndex:MyDateTimePickerPressButtonTypeSelect selectedDate:datePicker.date andCellRow:cellRow];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)pressCancelButton:(id)sender
{
    [delegate MyDateTimePickerViewController:self didPressButtonIndex:MyDateTimePickerPressButtonTypeCancel selectedDate:datePicker.date andCellRow:cellRow];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)pressClearButton:(id)sender
{
    [delegate MyDateTimePickerViewController:self didPressButtonIndex:MyDateTimePickerPressButtonTypeClear selectedDate:nil andCellRow:cellRow];
    [self dismissModalViewControllerAnimated:YES];
}
- (void)createBarItem
{
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Done", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(pressSelectButton:)];
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Clear", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(pressClearButton:)];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Close", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(pressCancelButton:)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *items = [[NSArray alloc] initWithObjects:doneItem, clearItem, flexItem, closeItem, nil];
    [toolBar setItems:items];
    [items release];
}
@end
