//
//  mainDateTableViewDelegate.m
//  TimeCounter
//
//  Created by 張星星 on 12/4/30.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "mainDateTableViewDelegate.h"

@implementation mainDateTableViewDelegate
@synthesize delegate;
@synthesize dateGroupArray, timerArray;

- (void)dealloc
{
    delegate = nil;
    [dateGroupArray release], dateGroupArray = nil;
    [timerArray release], timerArray = nil;
    [super dealloc];
}

#pragma mark - tableView delegate, dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dateGroupArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *itemArray = [timerArray objectAtIndex:section];
    return [itemArray count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [dateGroupArray objectAtIndex:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
/*
 - (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
 [label setBackgroundColor:[UIColor clearColor]];
 [label setTextColor:[UIColor yellowColor]];
 [label setText:@"我是測試標題"];
 return label;
 }
 */
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *customCellIdentifier = @"customCellIdentifier";
    customTimerCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customTimerCell" owner:self options:nil];
        for (id currentObj in topLevelObjects)
        {
            if ([currentObj isKindOfClass:[customTimerCell class]])
            {
                cell = currentObj;
            }
            break;
        }
    }
    NSUInteger row = [indexPath row];
    NSUInteger sec = [indexPath section];
    NSArray *itemArray = [timerArray objectAtIndex:sec];
    timeCounterInfo *info = [itemArray objectAtIndex:row];
    [cell.categoryLabel setText:info.categoryName];
    [cell.startDateLabel setText:info.createTime];
    [cell.endDateLabel setText:info.expireTime];
    [cell.descriptionLabel setText:info.intro];
    [cell.timeIntervalLabel setText:info.timeInterval];
    return cell;
}

//修改
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        // Delete the row from the data source
        [delegate dateTableView:self didDeleteTableViewCellAtIndex:indexPath];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) 
    {
        
    }   
}
#pragma mark - table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [delegate dateTableView:self didSelectTableViewCellAtIndex:indexPath];
}

@end
