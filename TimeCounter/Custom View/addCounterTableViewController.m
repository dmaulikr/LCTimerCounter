//
//  addCounterTableViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/3/31.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "addCounterTableViewController.h"
#import "customLabelCell.h"
#import "customTextFieldCell.h"

@interface addCounterTableViewController ()

- (void)createBarItem;
- (void)takePictureWithButtonIndex:(choosePictureSourseType)buttonIndex;
- (void)askPicutreSource;

@end

@implementation addCounterTableViewController
@synthesize currentInfo;
@synthesize delegate;
@synthesize isModify, modifyRow, modifyCategory, modifyDateString;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
    {
        self.title = NSLocalizedStringFromTable(@"addViewTitle", @"InfoPlist", @"新增畫面標題");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.tableView setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    [self createBarItem];
    if (currentInfo == nil)
    {
        newInfo = [[timeCounterInfo alloc] initWithNewInfo];
    }
    if (functionArray == nil)
    {
        functionArray = [[NSArray alloc] initWithObjects:
                         NSLocalizedStringFromTable(@"pictureCell", @"InfoPlist", nil),
                         NSLocalizedStringFromTable(@"descriptionCell", @"InfoPlist", nil)
                         , nil];
    }
    if (pictureGroup == nil)
    {
        pictureGroup = [[NSArray alloc] initWithObjects:
                        NSLocalizedStringFromTable(@"pictureCell", @"InfoPlist", nil),
                        NSLocalizedStringFromTable(@"startDateTime", @"InfoPlist", nil),
                        NSLocalizedStringFromTable(@"endDateTime",@"InfoPlist",nil),
                        NSLocalizedStringFromTable(@"notifyCell",@"InfoPlist",nil),
                        nil];
    }
    if (introGroup == nil)
    {
        introGroup = [[NSArray alloc] initWithObjects:
                      NSLocalizedStringFromTable(@"classCell", @"InfoPlist", nil),
                      NSLocalizedStringFromTable(@"descriptionCell", @"InfoPlist", nil)
                      , nil];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [functionArray release], functionArray = nil;
    [introGroup release], introGroup = nil;
    [pictureGroup release], pictureGroup = nil;
    [newInfo release], newInfo = nil;
    [modifyCategory release], modifyCategory = nil;
    [modifyDateString release], modifyDateString = nil;
    [super dealloc];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [functionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == addViewGroupOptionPicture)
        return [pictureGroup count];
    else if (section == addViewGroupOptionDescription)
        return [introGroup count];
    return 0;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [functionArray objectAtIndex:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSUInteger sec = [indexPath section];
    if (sec == addViewGroupOptionPicture)
    {
        if (row == pictureGroupTypePicture)
        {
            return 200;
        }
        return 40;
    }
    else if (sec == addViewGroupOptionDescription)
    {
        return 40;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *notifyCellIdentifier = @"notifyCellIdentifier";
    static NSString *classCellIdentifier = @"classCellIdentifier";
    static NSString *introCellIdentifier = @"introCellIdentifier";
    static NSString *customPictureCellIdeitifier = @"customPictureCellIdeitifier";
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    if (sec == addViewGroupOptionPicture)
    {
        if (row == pictureGroupTypePicture)
        {
            customPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:customPictureCellIdeitifier];
            if (cell == nil) 
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customPictureCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[customPictureCell class]])
                    {
                        cell = currentObj;
                    }
                    break;
                }
                [cell setDelegate:self];
                if (isModify == NO)
                {
                    if (![newInfo.imageFilePath isEqualToString:@"none"])
                    {
                        [cell setImageWithPath:newInfo.imageFilePath];
                    }
                    [cell.timeIntervalLabel setText:newInfo.timeInterval];
                }
                else
                {
                    if (![currentInfo.imageFilePath isEqualToString:@"none"])
                    {
                        [cell setImageWithPath:currentInfo.imageFilePath];
                    }
                    [cell.timeIntervalLabel setText:currentInfo.timeInterval];
                }
            }
            return cell;
        }
        else if (row == pictureGroupTypeStartDate)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            [cell.textLabel setText:[pictureGroup objectAtIndex:row]];
            if (isModify == NO)
                [cell.detailTextLabel setText:newInfo.createTime];
            else
                [cell.detailTextLabel setText:currentInfo.createTime];
            return cell;
        }
        else if (row == pictureGroupTypeEndDate)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            [cell.textLabel setText:[pictureGroup objectAtIndex:row]];
            if (isModify == NO)
                [cell.detailTextLabel setText:newInfo.expireTime];
            else
                [cell.detailTextLabel setText:currentInfo.expireTime];
            return cell;
        }
        else if (row == pictureGroupTypeNotify)
        {
            customNotifyCell *cell = [tableView dequeueReusableCellWithIdentifier:notifyCellIdentifier];
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customNotifyCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[customNotifyCell class]])
                    {
                        cell = currentObj;
                    }
                    break;
                }
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
            [cell.titleLabel setText:[NSString stringWithFormat:@"%@天後通知我(%@)", newInfo.notifyDays,
                                      [[GlobalFunctions shareInstance] getRepeatTypeName:[newInfo.notifyType integerValue]]]];
            return cell;
        }
    }
    else if (sec == addViewGroupOptionDescription)
    {
        if (row == descriptionGorupTypeClass)
        {
            customLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:classCellIdentifier];
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customLabelCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[customLabelCell class]])
                    {
                        cell = currentObj;
                    }
                    break;
                }
            }
            [cell.titleLabel setText:NSLocalizedStringFromTable(@"category", @"InfoPlist", nil)];
            if (isModify == NO)
                [cell.contentLabel setText:newInfo.categoryName];
            else
                [cell.contentLabel setText:currentInfo.categoryName];
            return cell;
        }
        else
        {
            customTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:introCellIdentifier];
            if (cell == nil)
            {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTextFieldCell" owner:self options:nil];
                for (id currentObj in topLevelObjects)
                {
                    if ([currentObj isKindOfClass:[customTextFieldCell class]])
                    {
                        cell = currentObj;
                    }
                    break;
                }
            }
            [cell.titleLabel setText:NSLocalizedStringFromTable(@"content", @"InfoPlist", nil)];
            [cell.contentTextField setPlaceholder:NSLocalizedStringFromTable(@"EnterDesc", @"InfoPlist", nil)];
            if (isModify == NO)
                [cell.contentTextField setText:newInfo.intro];
            else 
                [cell.contentTextField setText:currentInfo.intro];
            [cell.contentTextField setDelegate:self];
            
            return cell;
        }
    }
    return nil;
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
    if (sec == addViewGroupOptionPicture)
    {
        if (row == pictureGroupTypeStartDate | row == pictureGroupTypeEndDate)
        {
            MyDateTimePickerViewController *datetimePickre = [[MyDateTimePickerViewController alloc] initWithNibName:@"MyDateTimePickerViewController" bundle:nil];
            [datetimePickre setDelegate:self];
            //要分開是修改還是新增
            if (isModify == NO)
                datetimePickre.currentReminderDate = [DateFunction StringToDate:newInfo.createTime];
            else
                datetimePickre.currentReminderDate = [DateFunction StringToDate:currentInfo.createTime];
            datetimePickre.cellRow = row;
            [datetimePickre setModalTransitionStyle:UIModalTransitionStylePartialCurl];
            [self presentModalViewController:datetimePickre animated:YES];
            [datetimePickre release];
        }
        else if (row == pictureGroupTypeNotify)
        {
            customRepeatPickViewController *repeatPickerView = [[customRepeatPickViewController alloc] initWithNibName:@"customRepeatPickViewController" bundle:nil];
            [repeatPickerView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
            if (isModify == NO)
            {
                [repeatPickerView setNotifyType:[newInfo.notifyType integerValue]];
                [repeatPickerView setNotifyDays:[newInfo.notifyDays integerValue]];
            }
            else
            {
                [repeatPickerView setNotifyType:[currentInfo.notifyType integerValue]];
                [repeatPickerView setNotifyDays:[currentInfo.notifyDays integerValue]];
            }
            [repeatPickerView setDelegate:self];
            [self presentModalViewController:repeatPickerView animated:YES];
        }
    }
    else if (sec == addViewGroupOptionDescription)
    {
        if (row == descriptionGorupTypeClass)
        {
            customCategoryPickViewController *classPickerView = [[customCategoryPickViewController alloc] initWithNibName:@"customCategoryPickViewController" bundle:nil];
            [classPickerView setDelegate:self];
            //新增or修改
            if (isModify == NO)
                [classPickerView setCurrentCategory:newInfo.category];
            else 
                [classPickerView setCurrentCategory:currentInfo.category];
            [classPickerView setModalTransitionStyle:UIModalTransitionStylePartialCurl];
            [self presentModalViewController:classPickerView animated:YES];
            [classPickerView release];
        }
        else if (row == descriptionGorupTypeIntro)
        {
                        
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
//新的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    [picker dismissModalViewControllerAnimated:YES];
    if ([mediaType isEqualToString:@"public.image"])
    {
        UIImage *resultImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        //NSData *imageData = UIImageJPEGRepresentation(resultImage, 0.3);
        //resultImage = [UIImage imageWithData:imageData];
        resultImage = [resultImage fixOrientation];
        //將照片儲存至圖庫
        //UIImageWriteToSavedPhotosAlbum(resultImage,self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
        
        [self performSelectorOnMainThread:@selector(image:didFinishSavingWithError:contextInfo:) withObject:resultImage waitUntilDone:NO];
    }
    else if ([mediaType isEqualToString:@"public.movie"])
    {
        NSString *movieFilePath = [[info objectForKey:UIImagePickerControllerOriginalImage]
                                   path];
        [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Info" subTitle:movieFilePath hideAfter:2];
    }
}
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(NSDictionary*)info
{
    //同時將照片儲存至document資料夾中，同時更新pictureCell
    NSString *imageFileName = [NSString stringWithFormat:@"record%i.png", [newInfo.seq integerValue]];
    NSString *imageFilePath = [[GlobalFunctions shareInstance] getDocumentFullPath:imageFileName];
    if (isModify == NO)
        newInfo.imageFilePath = [NSString stringWithFormat:@"%@",imageFilePath];
    else 
        currentInfo.imageFilePath = [NSString stringWithFormat:@"%@",imageFilePath];
    [ProcessImage saveImage:image imageName:imageFilePath];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]
                          withRowAnimation:UITableViewRowAnimationNone];
    
    [infoPanel showPanelInView:self.view type:infoPanelTypeInfo title:@"Info" subTitle:@"Succeed!" hideAfter:2];
    
}
#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self takePictureWithButtonIndex:buttonIndex];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (isModify == NO)
        newInfo.intro = [textField text];
    else 
        currentInfo.intro = [textField text];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (isModify == NO)
        newInfo.intro = [textField text];
    else 
        currentInfo.intro = [textField text];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - pictureCell delegate
- (void)customPictureCell:(customPictureCell *)cell didPressButton:(customPictureCellButtonType)buttonType
{
    [self askPicutreSource];
}
#pragma mark - myDateTimePicker delegte
- (void)MyDateTimePickerViewController:(MyDateTimePickerViewController *)dateTimePicker didPressButtonIndex:(MyDateTimePickerPressButtonType)pressButtonIndex selectedDate:(NSDate *)aDate andCellRow:(NSInteger)row
{
    if (pressButtonIndex == MyDateTimePickerPressButtonTypeSelect)
    {
        if (isModify == NO)
        {
            //開始日期or結束日期
            if (row == pictureGroupTypeStartDate)
            {
                newInfo.createTime = [DateFunction DateToString:aDate];
            }
            else if (row == pictureGroupTypeEndDate)
            {
                newInfo.expireTime = [DateFunction DateToString:aDate];
            }
            newInfo.timeInterval = [DateFunction IntervalBetweenToday:[NSDate date] andDate:[DateFunction StringToDate:newInfo.createTime] andEndDate:[DateFunction StringToDate:newInfo.expireTime]];
        }
        else
        {
            if (row == pictureGroupTypeStartDate)
            {
                currentInfo.createTime = [DateFunction DateToString:aDate];
            }
            else if (row == pictureGroupTypeEndDate)
            {
                currentInfo.expireTime = [DateFunction DateToString:aDate];
            }
            currentInfo.timeInterval = [DateFunction IntervalBetweenToday:[NSDate date] andDate:[DateFunction StringToDate:currentInfo.createTime] andEndDate:[DateFunction StringToDate:currentInfo.expireTime]];
        }
        //[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - classPickerView delegate
- (void)classPickerView:(customCategoryPickViewController *)view didPickClass:(NSInteger)classInd andPickClassName:(NSString *)name
{
    if (isModify == NO)
    {
        newInfo.category = [NSString stringWithFormat:@"%i",classInd];
        newInfo.categoryName = name;
    }
    else 
    {
        currentInfo.category = [NSString stringWithFormat:@"%i",classInd];
        currentInfo.categoryName = name;
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - notifyCell delegate
- (void)notifyCell:(customNotifyCell *)cell didNotifySwitchChange:(BOOL)value
{
    if (!isModify)
    {
        newInfo.isNotify = value;
    }
    else
    {
        currentInfo.isNotify = value;
    }
}
#pragma mark - notifyPicker delegate

- (void)repeatPickerView:(customRepeatPickViewController *)view didPickRepeatType:(NSUInteger)unit andDays:(NSUInteger)days
{
    if (isModify == NO)
    {
        newInfo.notifyType = [[NSString alloc] initWithFormat:@"%i",unit];
        newInfo.notifyDays = [[NSString alloc] initWithFormat:@"%i",days];
    }
    else 
    {
        currentInfo.notifyType = [[NSString alloc] initWithFormat:@"%i",unit];
        currentInfo.notifyDays = [[NSString alloc] initWithFormat:@"%i",days];
    }
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - user define function

- (void)createBarItem
{
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Save", @"InfoPlist", nil) style:UIBarButtonItemStylePlain target:self action:@selector(confirmItemPress)];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"Close", @"InfoPlist", nil) style:UIBarButtonItemStylePlain target:self action:@selector(closeItemPress)];
    self.navigationItem.leftBarButtonItem = confirmItem;
    self.navigationItem.rightBarButtonItem = closeItem;
    [confirmItem release];
    [closeItem release];
}
- (void)confirmItemPress
{
    [self dismissModalViewControllerAnimated:YES];
    if (isModify == NO)
    {
        [[GlobalFunctions shareInstance] saveNewSerial:[newInfo.seq integerValue]];
        [delegate addCounterView:self didAddRecord:newInfo];
    }
    else 
        [delegate addCounterView:self didModify:currentInfo andRow:modifyRow andCategory:modifyCategory andDateString:modifyDateString];
}
- (void)closeItemPress
{
    [self dismissModalViewControllerAnimated:YES];
    if (isModify)
        [delegate addCounterView:self didModifyWithoutModify:currentInfo];
}
#pragma mark take picture
- (void)askPicutreSource
{
    UIActionSheet *actionsheet = [[[UIActionSheet alloc] 
                                   initWithTitle:NSLocalizedStringFromTable(@"CameraSource", @"InfoPlist", nil)
                                   delegate:self                  
                                   cancelButtonTitle:NSLocalizedStringFromTable(@"Cancel", @"InfoPlist", nil)
                                   destructiveButtonTitle:nil
                                   otherButtonTitles:NSLocalizedStringFromTable(@"TakePicture", @"InfoPlist", nil),NSLocalizedStringFromTable(@"PhotoAlbum", @"InfoPlist", nil), nil] autorelease];
    [actionsheet showInView:self.view];
}
- (void)takePictureWithButtonIndex:(choosePictureSourseType)buttonIndex
{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.navigationItem.title = @"";
	picker.delegate = self;
    picker.mediaTypes = [NSArray arrayWithObjects:@"public.image",nil];
	if(buttonIndex == choosePictureSourseTypeLibrary)
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
    }
    else if (buttonIndex == choosePictureSourseTypeCamera)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        {
            [infoPanel showPanelInView:self.view type:infoPanelTypeError title:@"Info" subTitle:NSLocalizedStringFromTable(@"CameraNotSupport", @"InfoPlist", nil) hideAfter:2];
        }
        else
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:picker animated:YES];
        }	
	}
}

@end
