//
//  customCategoryHandleTableViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/5/8.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customCategoryHandleTableViewController.h"
#import "GlobalFunctions.h"

@interface customCategoryHandleTableViewController ()

- (void)createBarItem;
- (void)addCategoryItem;

@end

@implementation customCategoryHandleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    if (categoryArray == nil)
    {
        categoryArray = [[NSMutableArray alloc] initWithArray:[[GlobalFunctions shareInstance] getCategoryArray]];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [categoryArray release], categoryArray = nil;
    [super dealloc];
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
    return [categoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSUInteger row = [indexPath row];
    [cell.textLabel setText:[categoryArray objectAtIndex:row]];
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        NSUInteger row = [indexPath row];
        [categoryArray removeObjectAtIndex:row];
        [[GlobalFunctions shareInstance] saveCategoryArray:categoryArray];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}



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
    addCategoryViewController *addView = [[addCategoryViewController alloc] initWithNibName:@"addCategoryViewController" bundle:nil];
    [addView setCurrentCategoryName:[categoryArray objectAtIndex:row]];
    [addView setIsModify:YES];
    [addView setModifyIndexPath:indexPath];
    [addView setDelegate:self];
    [addView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:addView animated:YES];
    [addView release];
    
}

#pragma mark - addCategoryView

- (void)addCategoryView:(addCategoryViewController *)view didAddCategory:(NSString *)categoryName
{
    [categoryArray addObject:categoryName];
    [[GlobalFunctions shareInstance] saveCategoryArray:categoryArray];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[categoryArray count] - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)addCategoryView:(addCategoryViewController *)view didModifyCategory:(NSString *)categoryName andIndexPath:(NSIndexPath *)indexPath
{
    [categoryArray replaceObjectAtIndex:[indexPath row] withObject:categoryName];
    [[GlobalFunctions shareInstance] saveCategoryArray:categoryArray];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - user define function


- (void)createBarItem
{
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(addCategoryItem)];
    self.navigationItem.rightBarButtonItem = addItem;
    [addItem release];
}

- (void)addCategoryItem
{
    addCategoryViewController *addView = [[addCategoryViewController alloc] initWithNibName:@"addCategoryViewController" bundle:nil];
    [addView setDelegate:self];
    [addView setIsModify:NO];
    [addView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:addView animated:YES];
    [addView release];
}


@end
