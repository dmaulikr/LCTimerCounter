//
//  customSortPickerViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/5/1.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customSortPickerViewController.h"
#import "GlobalFunctions.h"

@interface customSortPickerViewController ()

- (void)createBarItem;
- (void)backItemPress;
- (void)doneItemPress;

@end

@implementation customSortPickerViewController
@synthesize delegate;
@synthesize currentSortType;
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
    [self createBarItem];
    if (sortTypeArray == nil)
    {
        sortTypeArray = [[NSArray alloc] initWithObjects:NSLocalizedStringFromTable(@"sortCategory", @"InfoPlist",nil),NSLocalizedStringFromTable(@"sortDate", @"InfoPlist", nil), nil];
    }
    [sortPicker setDelegate:self];
    [sortPicker setDataSource:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    currentSortType = [[GlobalFunctions shareInstance] getSyncronizedValueWithKey:sortTypeKey];
    //sortType = sortByDate;
    if (currentSortType == nil)
        currentSortType = sortByCategory;
    if ([currentSortType isEqualToString:sortByCategory])
        [sortPicker selectRow:sortTypeIndexCategory inComponent:0 animated:YES];
    else if ([currentSortType isEqualToString:sortByDate])
        [sortPicker selectRow:sortTypeIndexDate inComponent:0 animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [toolBar release], toolBar = nil;
    [sortPicker release], sortPicker = nil;
    [sortTypeArray release], sortTypeArray = nil;
    [currentSortType release], currentSortType = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIPickerView delegate, UIPickerView dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [sortTypeArray count];
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setText:[sortTypeArray objectAtIndex:row]];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

#pragma mark - user define function

- (void)createBarItem
{
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Done", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(doneItemPress)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Close", @"InfoPlist", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(backItemPress)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *items = [[NSArray alloc] initWithObjects:doneItem,flexItem,backItem, nil];
    [toolBar setItems:items];
    [items release];
}
- (void)backItemPress
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)doneItemPress
{
    [delegate sortPickerView:self didPickSortWithType:[sortTypeArray objectAtIndex:[sortPicker selectedRowInComponent:0]] andSortTypeIndex:[sortPicker selectedRowInComponent:0]];
    [self dismissModalViewControllerAnimated:YES];
}
@end
