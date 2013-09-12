//
//  AboutViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/5/6.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

- (void)createBarItem;
- (void)backItemPress;

- (void)showTellUsMail;
- (void)showTellFriendMail;

@end

@implementation AboutViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title = NSLocalizedStringFromTable(@"aboutus", @"InfoPlist", nil);
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
                         NSLocalizedStringFromTable(@"feedback", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"introduction", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"copyright", @"InfoPlist", nil), nil];
    }
    if (feedBackArray == nil)
    {
        feedBackArray = [[NSArray alloc] initWithObjects:
                         NSLocalizedStringFromTable(@"rate", @"InfoPlist", nil), 
                         NSLocalizedStringFromTable(@"tellfriend", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"tellus", @"InfoPlist", nil),
                         nil];
    }
    if (introductionArray == nil)
    {
        introductionArray = [[NSArray alloc] initWithObjects:
                             NSLocalizedStringFromTable(@"title", @"InfoPlist", nil),
                             NSLocalizedStringFromTable(@"more", @"InfoPlist", nil), nil];
    }
    if (copyRightArray == nil)
    {
        copyRightArray = [[NSArray alloc] initWithObjects:
                          NSLocalizedStringFromTable(@"copyright", @"InfoPlist", nil), nil];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [functionArray release], functionArray = nil;
    [feedBackArray release], feedBackArray = nil;
    [introductionArray release], introductionArray = nil;
    [copyRightArray release], copyRightArray = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [functionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == aboutFunctionTypeFeedback)
        return [feedBackArray count];
    else if (section == aboutFunctionTypeIntroduction)
        return [introductionArray count];
    else if (section == aboutFunctionTypeCopyright)
        return [copyRightArray count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    
    if (sec == aboutFunctionTypeFeedback)
    {
        [cell.textLabel setText:[feedBackArray objectAtIndex:row]];
    }
    else if (sec == aboutFunctionTypeIntroduction)\
    {
        [cell.textLabel setText:[introductionArray objectAtIndex:row]];
    }
    else if (sec == aboutFunctionTypeCopyright)
    {
        [cell.textLabel setText:[copyRightArray objectAtIndex:row]];
    }
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
    NSUInteger row = [indexPath row];
    if (sec == aboutFunctionTypeFeedback)
    {
        if (row == feedBackRowTellFriend)
        {
            [self showTellFriendMail];
        }
        else if (row == feedBackRowTellUs)
        {
            [self showTellUsMail];
        }
        else if (row == feedBackRowRateUs)
        {
            //itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID
        }
    }
}

#pragma mark - send mail delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *message;
    switch (result) 
    {
        case MFMailComposeResultCancelled:
            message = @"Result: cancel send";
            break;
        case MFMailComposeResultSaved:
            message = @"Result: Mail Saved";
            break;
        case MFMailComposeResultFailed:
            message = @"Result: Mail Send Faild";
            break;
        case MFMailComposeResultSent:
            message = @"Result: Mail send";
            break;
        default:
            message = @"Result : Mail no Send";
            break;
    }
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
    //[self dismissModalViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)showTellUsMail
{
    //iOS 3.0就支援了
    MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
    compose.mailComposeDelegate = self;
    [compose setSubject:@"HouseKeeper App"];
    
    NSArray *toRecipients = [NSArray arrayWithObjects:@"",nil];
    [compose setToRecipients:toRecipients];
    //附加檔案
    
    NSString *emailBody = @"Dear HouseKeeper";
    
    [compose setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController:compose animated:YES];
    UIImage *image = [UIImage imageNamed:@""];
    [[[[compose navigationBar] items] objectAtIndex:0] setTitleView:[[UIImageView alloc] initWithImage:image]];    
}
- (void)showTellFriendMail
{
    //iOS 3.0就支援了
    MFMailComposeViewController *compose = [[MFMailComposeViewController alloc] init];
    compose.mailComposeDelegate = self;
    [compose setSubject:@"HouseKeeper App"];
    //附加檔案
    
    NSString *emailBody = @"Dear";
    
    [compose setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController:compose animated:YES];
    UIImage *image = [UIImage imageNamed:@""];
    [[[[compose navigationBar] items] objectAtIndex:0] setTitleView:[[UIImageView alloc] initWithImage:image]];    
}
@end
