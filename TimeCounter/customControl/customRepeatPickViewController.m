//
//  customRepeatPickViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/5/10.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customRepeatPickViewController.h"

@interface customRepeatPickViewController ()

- (void)createToolBarItem;

- (IBAction)backItemPress:(id)sender;
- (IBAction)confirmItemPress:(id)sender;

@end

@implementation customRepeatPickViewController

@synthesize delegate;
@synthesize notifyType, notifyDays;

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
    [repeatPicker setDelegate:self];
    [repeatPicker setDataSource:self];
    if (repeatTypeArray == nil)
    {
        repeatTypeArray = [[NSArray alloc] initWithObjects:
                           @"每天",
                           @"每週",
                           nil];
    }
    if (daysArray == nil)
    {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:30];
        for (int i = 0; i <= 100; i++)
        {
            [array addObject:[NSString stringWithFormat:@"%i",i]];
        }
        daysArray = [[NSArray alloc] initWithArray:array];
        [array release];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [repeatPicker selectRow:notifyType inComponent:0 animated:YES];
    [repeatPicker selectRow:notifyDays inComponent:1 animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [toolbar release], toolbar = nil;
    [repeatPicker release], repeatPicker = nil;
    [repeatTypeArray release], repeatTypeArray = nil;
    [daysArray release], daysArray = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIPickerView delegate, UIPickerView dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == repeatPickerComponentType)
        return [repeatTypeArray count];
    else if (component == repeatPickerComponentDays)
        return [daysArray count];
    return 0;
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    if (component == repeatPickerComponentType)
    {
        [label setTextAlignment:UITextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"Helvetica Bold" size:17]];
        [label setText:[repeatTypeArray objectAtIndex:row]];
    }
    else if (component == repeatPickerComponentDays)
    {
        [label setTextAlignment:UITextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"Helvetica Bold" size:17]];
        [label setText:[daysArray objectAtIndex:row]];
    }
    return label;
}

#pragma mark - user define function

- (IBAction)backItemPress:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)confirmItemPress:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    [delegate repeatPickerView:self didPickRepeatType:[repeatPicker selectedRowInComponent:0] andDays:[repeatPicker selectedRowInComponent:1]];
}

- (void)createToolBarItem
{
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Done", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(confirmItemPress:)];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Close", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(backItemPress:)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *items = [[NSArray alloc] initWithObjects:doneItem, flexItem, closeItem, nil];
    [toolbar setItems:items];
    [items release];
}

@end
