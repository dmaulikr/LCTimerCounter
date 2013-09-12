//
//  ConfigViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/5/6.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "ConfigViewController.h"
#import "GlobalFunctions.h"

@interface ConfigViewController ()

- (void)createBarItem;
- (void)backItemPress;

@end

@implementation ConfigViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title = NSLocalizedStringFromTable(@"setting", @"InfoPlist", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarItem];
    if (functionArray == nil)
    {
        functionArray = [[NSArray alloc] initWithObjects:@"類別維護",@"排序", nil];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [functionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    NSUInteger row = [indexPath row];
    [cell.textLabel setText:[functionArray objectAtIndex:row]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    if (row == configFunctionTypeCategory)
    {
        customCategoryHandleTableViewController *categoryHandleView = [[customCategoryHandleTableViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:categoryHandleView animated:YES];
        [categoryHandleView release];
    }
    else if (row == configFunctionTypeSort)
    {
        customSortPickerViewController *sortView = [[customSortPickerViewController alloc] initWithNibName:@"customSortPickerViewController" bundle:nil];
        [sortView setDelegate:self];
        [sortView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
        [self presentModalViewController:sortView animated:YES];
        [sortView release];
    }
}

#pragma mark - sortPicker delegate

- (void)sortPickerView:(customSortPickerViewController *)view didPickSortWithType:(NSString *)sortType andSortTypeIndex:(sortTypeIndex)sortInd
{
    if (sortInd == sortTypeIndexCategory)
    {
        [[GlobalFunctions shareInstance] saveSyncronizedWithKey:sortTypeKey andValue:sortByCategory];
    }
    else if (sortInd == sortTypeIndexDate)
    {
        [[GlobalFunctions shareInstance] saveSyncronizedWithKey:sortTypeKey andValue:sortByDate];
    }
    
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
@end
