//
//  customClassPickViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/4/25.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customCategoryPickViewController.h"
#import "GlobalFunctions.h"

@interface customCategoryPickViewController ()

- (void)createToolBarItem;

- (IBAction)backItemPress:(id)sender;
- (IBAction)confirmItemPress:(id)sender;

@end

@implementation customCategoryPickViewController
@synthesize delegate, currentCategory;

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
    if (classArray == nil)
    {
        /*
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"category" ofType:@"plist"]];
        if ([[GlobalFunctions shareInstance] currentLanguageInd] == 0)
            classArray = [[NSArray alloc] initWithArray:[dict valueForKey:@"category_tw"]];
        else
            classArray = [[NSArray alloc] initWithArray:[dict valueForKey:@"category_en"]];
        [dict release];
         */
        classArray = [[NSArray alloc] initWithArray:[[GlobalFunctions shareInstance] getCategoryArray]];
    }
    [classPicker setDelegate:self];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [classPicker selectRow:[currentCategory integerValue] inComponent:0 animated:YES];
}
- (void)dealloc
{
    delegate = nil;
    [classArray release], classArray = nil;
    [classPicker release], classPicker = nil;
    [toolbar release], toolbar = nil;
    [currentCategory release], currentCategory = nil;
    [super dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIPickerView delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [classArray count];
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setFont:[UIFont fontWithName:@"Helvetica Bold" size:17]];
    [label setText:[classArray objectAtIndex:row]];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

- (IBAction)backItemPress:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)confirmItemPress:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    [delegate classPickerView:self didPickClass:[classPicker selectedRowInComponent:0] andPickClassName:[classArray objectAtIndex:[classPicker selectedRowInComponent:0]]];
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
