//
//  settingTableViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/5/1.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "settingTableViewController.h"
#import "GlobalFunctions.h"

@interface settingTableViewController ()

@end

@implementation settingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarItem];
    if (functionArray == nil)
    {
        functionArray = [[NSArray alloc] initWithObjects:
                         NSLocalizedStringFromTable(@"help", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"setting", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"aboutus", @"InfoPlist", nil), nil];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [functionArray release], functionArray = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [functionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == functionTypeAbout)
    {
        return @"©2012 Mountain Star";
    }
    return @"";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //NSUInteger row = [indexPath row];
    NSUInteger sec = [indexPath section];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    [cell.textLabel setText:[functionArray objectAtIndex:sec]];
    
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
    NSUInteger sec = [indexPath section];
    if (sec == functionTypeHelp)
    {
        /*
        HelpViewController *helpView = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
        [self.navigationController pushViewController:helpView animated:YES];
        [helpView release];
         */
        NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
        
        //NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];
        
        //NSString *filePath = [pdfs lastObject]; assert(filePath != nil); // Path to last PDF file
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"iphone_class" ofType:@"pdf"];
        
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
        
        if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
        {
            ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
            
            readerViewController.delegate = self; // Set the ReaderViewController delegate to self
            
//#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
            
            //[self.navigationController pushViewController:readerViewController animated:YES];
            
//#else // present in a modal view controller
            
            readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentModalViewController:readerViewController animated:YES];
             
            
//#endif // DEMO_VIEW_CONTROLLER_PUSH
            
            [readerViewController release]; // Release the ReaderViewController
        }
    }
    else if (sec == functionTypeConfig)
    {
        ConfigViewController *configView = [[ConfigViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:configView animated:YES];
        [configView release];
    }
    else if (sec == functionTypeAbout)
    {
        AboutViewController *aboutView = [[AboutViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:aboutView animated:YES];
        [aboutView release];
    }
}

#pragma mark - ReaderViewController delegate

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissModalViewControllerAnimated:YES];
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
