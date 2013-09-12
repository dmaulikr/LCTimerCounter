//
//  mainViewController.m
//  TimeCounter
//
//  Created by 張星星 on 12/4/12.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "mainViewController.h"
#import "timeCounterInfo.h"
#import "MKLocalNotificationsScheduler.h"

@interface mainViewController ()

- (void)createBarItem;
- (void)createTitleView;
- (void)createToolBarItem;
- (void)infoItemPress;
- (void)createTimerArray;
- (void)showCategoryPickerView;
/*
 儲存檔案、讀取檔案
 */
- (void)saveTimeRecord;
- (void)loadTimeRecord;
- (void)makeDateTimerArray;
- (NSInteger)addDateGroupItem:(NSString*)dateString;
- (void)reloadAllData;
- (void)searchTimeArray;
@end

@implementation mainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        self.title = NSLocalizedStringFromTable(@"mainTitle", @"InfoPlist", @"主畫面標題");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarItem];
    [self createTitleView];
    [self createToolBarItem];
    sortType = [[GlobalFunctions shareInstance] getSyncronizedValueWithKey:sortTypeKey];
    if (sortType == nil)
        sortType = sortByCategory;
    if (categoryArray == nil)
    {
        /*
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"category" ofType:@"plist"]];
        if ([[GlobalFunctions shareInstance] currentLanguageInd] == 0)
            categoryArray = [[NSArray alloc] initWithArray:[dict valueForKey:@"category_tw"]];
        else
            categoryArray = [[NSArray alloc] initWithArray:[dict valueForKey:@"category_en"]];
        [dict release];
         */
        categoryArray = [[NSArray alloc] initWithArray:[[GlobalFunctions shareInstance] getCategoryArray]];
    }
    //依照分類來排列之delegate
    if (categoryDelegate == nil)
    {
        categoryDelegate = [[mainCategoryTableViewDelegate alloc] init];
        [categoryDelegate setDelegate:self];
    }
    if (dateDelegate == nil)
    {
        dateDelegate = [[mainDateTableViewDelegate alloc] init];
        [dateDelegate setDelegate:self];
    }
    //預設搜尋類別值為 0
    searchCategory = - 1;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [searchBar setText:[NSString stringWithFormat:@""]];
    searchKey = [NSString stringWithFormat:@""];
    searchCategory = -1;
    [self reloadAllData];
}
- (void)dealloc
{
    [mainTableView release], mainTableView = nil;
    [searchBar release], searchBar = nil;
    [dateGroupArray release], dateGroupArray = nil;
    [categoryArray release], categoryArray = nil;
    [timerArray release], timerArray = nil;
    [allArray release], allArray = nil;
    [searchResultArray release], searchResultArray = nil;
    [categoryDelegate release], categoryDelegate = nil;
    [dateDelegate release], dateDelegate = nil;
    [sortType release], sortType = nil;
    [searchKey release], searchKey = nil;
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - categoryTableviewDelegate
- (void)categoryTableView:(mainCategoryTableViewDelegate *)view didSelectTableViewAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    addCounterTableViewController *addView = [[addCounterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    NSArray *itemArray = [timerArray objectAtIndex:sec];
    timeCounterInfo *info = [itemArray objectAtIndex:row];
    /*
     移除local notification
     */
    NSString *fireDateString = [NSString stringWithFormat:@"%@ 18:00:00",info.expireTime];
    if (info.isNotify  && info.expireTime != nil)
    {
        [MKLocalNotificationsScheduler cancelNotificationOn:[DateFunction StringToDate:fireDateString] endReminderDate:[DateFunction StringToDate:fireDateString] repeatInterval:[info.notifyType integerValue] text:[NSString stringWithFormat:@"提醒您%@即將到期。",info.intro] action:nil sound:nil launchImage:nil andInfo:nil delayUnit:[info.notifyDays integerValue]];
    }
    addView.currentInfo = info;
    [addView setIsModify:YES];
    [addView setModifyCategory:info.category];
    [addView setDelegate:self];
    [addView setModifyRow:[indexPath row]];
    UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:addView];
    [addView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:navControl animated:YES];
    [addView release];
    [navControl release];
}
- (void)categoryTableView:(mainCategoryTableViewDelegate *)view didDeleteTableViewAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    NSMutableArray *itemArray = [timerArray objectAtIndex:sec];
    timeCounterInfo *info = [itemArray objectAtIndex:row];
    /*
     移除local notification
     */
    NSString *fireDateString = [NSString stringWithFormat:@"%@ 18:00:00",info.expireTime];
    if (info.isNotify  && info.expireTime != nil)
    {
        [MKLocalNotificationsScheduler cancelNotificationOn:[DateFunction StringToDate:fireDateString] endReminderDate:[DateFunction StringToDate:fireDateString] repeatInterval:[info.notifyType integerValue] text:[NSString stringWithFormat:@"提醒您%@即將到期。",info.intro] action:nil sound:nil launchImage:nil andInfo:nil delayUnit:[info.notifyDays integerValue]];
    }
    [itemArray removeObjectAtIndex:row];
    [timerArray replaceObjectAtIndex:sec withObject:itemArray];
    [self saveTimeRecord];
}
#pragma mark - dateTableViewDelegate 依照日期排序delegate
- (void)dateTableView:(mainDateTableViewDelegate *)view didSelectTableViewCellAtIndex:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    addCounterTableViewController *addView = [[addCounterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    NSArray *itemArray = [timerArray objectAtIndex:sec];
    timeCounterInfo *info = [itemArray objectAtIndex:row];
    /*
     移除local notification
     */
    NSString *fireDateString = [NSString stringWithFormat:@"%@ 18:00:00",info.expireTime];
    if (info.isNotify  && info.expireTime != nil)
    {
        [MKLocalNotificationsScheduler cancelNotificationOn:[DateFunction StringToDate:fireDateString] endReminderDate:[DateFunction StringToDate:fireDateString] repeatInterval:[info.notifyType integerValue] text:[NSString stringWithFormat:@"提醒您%@即將到期。",info.intro] action:nil sound:nil launchImage:nil andInfo:nil delayUnit:[info.notifyDays integerValue]];
    }
    addView.currentInfo = info;
    [addView setModifyDateString:[DateFunction GetYearAndMonthWithDate:info.createTime]];
    [addView setIsModify:YES];
    [addView setDelegate:self];
    [addView setModifyRow:[indexPath row]];
    UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:addView];
    [addView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:navControl animated:YES];
    [addView release];
    [navControl release];
}
- (void)dateTableView:(mainDateTableViewDelegate *)view didDeleteTableViewCellAtIndex:(NSIndexPath *)indexPath
{
    NSUInteger sec = [indexPath section];
    NSUInteger row = [indexPath row];
    NSMutableArray *itemArray = [timerArray objectAtIndex:sec];
    timeCounterInfo *info = [itemArray objectAtIndex:row];
    /*
     移除local notification
     */
    NSString *fireDateString = [NSString stringWithFormat:@"%@ 18:00:00",info.expireTime];
    if (info.isNotify  && info.expireTime != nil)
    {
        [MKLocalNotificationsScheduler cancelNotificationOn:[DateFunction StringToDate:fireDateString] endReminderDate:[DateFunction StringToDate:fireDateString] repeatInterval:[info.notifyType integerValue] text:[NSString stringWithFormat:@"提醒您%@即將到期。",info.intro] action:nil sound:nil launchImage:nil andInfo:nil delayUnit:[info.notifyDays integerValue]];
    }
    [itemArray removeObjectAtIndex:row];
    [timerArray replaceObjectAtIndex:sec withObject:itemArray];
    [self saveTimeRecord];
}
#pragma mark - UISearchBar delegate
- (BOOL)searchBar:(UISearchBar *)search shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    searchKey = [[NSString alloc] initWithFormat:[searchBar text]];
    [self reloadAllData];
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)search
{
    [search resignFirstResponder];
    searchKey = [[NSString alloc] initWithFormat:[searchBar text]];
    [self reloadAllData];
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    [self showCategoryPickerView];
}
#pragma mark - classPickerView delegate
- (void)classPickerView:(customCategoryPickViewController *)view didPickClass:(NSInteger)classInd andPickClassName:(NSString *)name
{
    searchCategory = classInd;
}
#pragma mark - addCounter delegate  新增、刪除、修改 timeCounterInfo
- (void)addCounterView:(addCounterTableViewController *)view didAddRecord:(timeCounterInfo *)info
{
    if ([sortType isEqualToString:sortByCategory])
    {
        NSArray *itemArray = [timerArray objectAtIndex:[info.category integerValue]];
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:itemArray];
        [array addObject:info];
        itemArray = [[NSArray alloc] initWithArray:array];
        [array release];
        [timerArray replaceObjectAtIndex:[info.category integerValue] withObject:itemArray];
        [categoryDelegate setTimerArray:timerArray];
    }
    else if ([sortType isEqualToString:sortByDate])
    {
        NSString *dateString = [DateFunction GetYearAndMonthWithDate:info.createTime];
        NSUInteger ind = [dateGroupArray indexOfObject:dateString];
        if (ind == NSNotFound)
        {
            ind = [self addDateGroupItem:dateString];
        }
        NSMutableArray *itemArray = [timerArray objectAtIndex:ind];
        [itemArray addObject:info];
        [timerArray replaceObjectAtIndex:ind withObject:itemArray];
    }
    //註冊local notification
    NSString *fireDateString = [NSString stringWithFormat:@"%@ 18:00:00",info.expireTime];
    if (info.isNotify  && info.expireTime != nil)
    {
        [MKLocalNotificationsScheduler scheduleNotificationOn:[DateFunction StringToDate2:fireDateString] endReminderDate:[DateFunction StringToDate2:fireDateString] repeatInterval:[info.notifyType integerValue] text:[NSString stringWithFormat:@"提醒您%@即將到期。",info.intro] action:nil sound:nil launchImage:nil andInfo:nil delayUnit:[info.notifyDays integerValue]];
    }
    [mainTableView reloadData]; 
    //儲存檔案
    [self saveTimeRecord];
}
- (void)addCounterView:(addCounterTableViewController *)view didModify:(timeCounterInfo *)info andRow:(NSUInteger)row andCategory:(NSString*)category andDateString:(NSString *)dateString
{
    if ([sortType isEqualToString:sortByCategory])
    {
        /*
         依照分類來排序時的做法
         */
        if ([category integerValue] == [info.category integerValue])
        {
            //如果和原本分類相同，則直接取代
            NSMutableArray *itemArray = [timerArray objectAtIndex:[category integerValue]];
            [itemArray replaceObjectAtIndex:row withObject:info];
            [timerArray replaceObjectAtIndex:[info.category integerValue] withObject:itemArray];
        }
        else 
        {
            //如果和原本分型不同，則移除舊的加入至新的分類中
            NSMutableArray *itemArray = [[NSMutableArray alloc] initWithArray:[timerArray objectAtIndex:[category integerValue]]];
            [itemArray removeObjectAtIndex:row];
            [timerArray replaceObjectAtIndex:[category integerValue] withObject:itemArray];
            [itemArray release];
            itemArray = [[NSMutableArray alloc] initWithArray:[timerArray objectAtIndex:[info.category integerValue]]];
            [itemArray addObject:info];
            [timerArray replaceObjectAtIndex:[info.category integerValue] withObject:itemArray];
            [itemArray release];
        }
        [categoryDelegate setTimerArray:timerArray];
    }
    else if ([sortType isEqualToString:sortByDate])
    {
        NSString *newDateString = [DateFunction GetYearAndMonthWithDate:info.createTime];
        if ([dateString isEqualToString:newDateString])
        {
            //如果和原本日期相同則直接取代
            NSUInteger ind = [dateGroupArray indexOfObject:dateString];
            NSMutableArray *itemArray = [timerArray objectAtIndex:ind];
            [itemArray replaceObjectAtIndex:row withObject:info];
            [timerArray replaceObjectAtIndex:ind withObject:itemArray];
        }
        else
        {
            //不同則先移除舊的在新增一筆至新的
            NSUInteger ind = [dateGroupArray indexOfObject:dateString];
            NSMutableArray *itemArray = [timerArray objectAtIndex:ind];
            [itemArray removeObjectAtIndex:row];
            //新增至新群組
            ind = [dateGroupArray indexOfObject:newDateString];
            if (ind == NSNotFound)
            {
                ind = [self addDateGroupItem:newDateString];
            }
            itemArray = [timerArray objectAtIndex:ind];
            [itemArray addObject:info];
            [timerArray replaceObjectAtIndex:ind withObject:itemArray];
        }
    }
    //註冊local notification
    NSString *fireDateString = [NSString stringWithFormat:@"%@ 18:00:00",info.expireTime];
    if (info.isNotify  && info.expireTime != nil)
    {
        [MKLocalNotificationsScheduler scheduleNotificationOn:[DateFunction StringToDate2:fireDateString] endReminderDate:[DateFunction StringToDate2:fireDateString] repeatInterval:[info.notifyType integerValue] text:[NSString stringWithFormat:@"提醒您%@即將到期。",info.intro] action:nil sound:nil launchImage:nil andInfo:nil delayUnit:[info.notifyDays integerValue]];
    }
    [mainTableView reloadData];
    [self saveTimeRecord];
}
- (void)addCounterView:(addCounterTableViewController *)view didModifyWithoutModify:(timeCounterInfo *)info
{
    /*
     移除local notification
     */
    NSString *fireDateString = [NSString stringWithFormat:@"%@ 18:00:00",info.expireTime];
    if (info.isNotify  && info.expireTime != nil)
    {
        [MKLocalNotificationsScheduler scheduleNotificationOn:[DateFunction StringToDate2:fireDateString] endReminderDate:[DateFunction StringToDate2:fireDateString] repeatInterval:[info.notifyType integerValue] text:[NSString stringWithFormat:@"提醒您%@即將到期。",info.intro] action:nil sound:nil launchImage:nil andInfo:nil delayUnit:[info.notifyDays integerValue]];
    }
}

#pragma mark - user define function

- (void)createBarItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [button addTarget:self action:@selector(infoItemPress) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *infoItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = infoItem;
    UIBarButtonItem *createItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(addButtonPress:)];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:createItem,nil];
    [infoItem release];
}
- (void)createTitleView
{
    //UIToolbar *searchBarToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //UIBarButtonItem *closeKeyboardItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-previous-50.png"] style:UIBarButtonItemStylePlain target:self action:@selector(closeKeyboardPress)];
    //searchBarToolBar.items = [[NSArray alloc] initWithObjects:closeKeyboardItem, nil];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIButton *closeKeyboardButton = [[UIButton alloc] initWithFrame:CGRectMake(285, 0, 40, 30)];
    [closeKeyboardButton addTarget:self action:@selector(closeSearchBarKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:closeKeyboardButton];
    [closeKeyboardButton setImage:[UIImage imageNamed:@"detailKeyIcon"] forState:UIControlStateNormal];
    searchBar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    searchBar.inputAccessoryView = view;
    [searchBar setDelegate:self];
    [searchBar setShowsSearchResultsButton:YES];
    self.navigationItem.titleView = searchBar;
}
- (void)createToolBarItem
{
    UIBarButtonItem *hideItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-previous-50.png"] style:UIBarButtonItemStylePlain target:self action:@selector(hideToolBarItemPress)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *showAllItem = [[UIBarButtonItem alloc] initWithTitle:@"還原" style:UIBarButtonItemStyleDone target:self action:@selector(showAllItemPress)];
    self.toolbarItems = [[NSArray alloc] initWithObjects:hideItem,flexItem,showAllItem, nil];
    [hideItem release];
    [flexItem release];
    [showAllItem release];
}
- (void)addButtonPress:(id)sender
{
    addCounterTableViewController *addView = [[addCounterTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [addView setDelegate:self];
    [addView setIsModify:NO];
    UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:addView];
    [addView setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:navControl animated:YES];
    [addView release];
    [navControl release];
}
- (IBAction)showToolBarPress:(id)sender
{
    [self.navigationController setToolbarHidden:NO animated:YES];
}
- (void)showCategoryPickerView
{
    customCategoryPickViewController *categoryPicker = [[customCategoryPickViewController alloc] initWithNibName:@"customCategoryPickViewController" bundle:nil];
    [categoryPicker setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [categoryPicker setDelegate:self];
    [self presentModalViewController:categoryPicker animated:YES];
}
- (void)infoItemPress
{
    /*
    settingTableViewController *settingView = [[settingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:settingView];
    [settingView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:nav animated:YES];
    [nav release];
    [settingView release];
     */
    settingTableViewController *settingView = [[settingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingView animated:YES];
    [settingView release];
}
- (void)showAllItemPress
{
    
}
- (void)hideToolBarItemPress
{
    [self.navigationController setToolbarHidden:YES animated:YES];
}
- (void)closeKeyboardPress
{
    
}
- (void)closeSearchBarKeyboard
{
    [searchBar resignFirstResponder];
}
#pragma mark 存檔、讀檔
- (void)reloadAllData
{
    //取得排序類型，如果第一次啟動則預設排序為『分類』
    sortType = [[GlobalFunctions shareInstance] getSyncronizedValueWithKey:sortTypeKey];
    //sortType = sortByDate;
    if (sortType == nil)
        sortType = sortByCategory;
    //建立新的資料
    [self createTimerArray];
    //讀取檔案
    [self loadTimeRecord];
    /*
     設定 tableView 的 delegate
     */
    if ([sortType isEqualToString:sortByCategory])
    {
        [categoryDelegate setTimerArray:timerArray];
        [categoryDelegate setCategoryArray:categoryArray];
        [mainTableView setDelegate:categoryDelegate];
        [mainTableView setDataSource:categoryDelegate];
    }
    else if ([sortType isEqualToString:sortByDate])
    {
        [dateDelegate setDateGroupArray:dateGroupArray];
        [dateDelegate setTimerArray:timerArray];
        [mainTableView setDelegate:dateDelegate];
        [mainTableView setDataSource:dateDelegate];
    }
    [mainTableView reloadData];
}
#pragma mark 儲存所有的timeCounterInfo至本機端
- (void)saveTimeRecord
{
    NSString *filePath = [[GlobalFunctions shareInstance] getDocumentFullPath:timeRecordFileName];
    NSMutableArray *saveArray = [[NSMutableArray alloc] initWithCapacity:[timerArray count]];
    for (NSArray *array in timerArray)
    {
        for (timeCounterInfo *info in array)
        {
            [saveArray addObject:[info createTimerWithDictionary]];
        }
        NSLog(@"%@",saveArray);
    }
    if (![saveArray writeToFile:filePath atomically:YES])
    {
        NSLog(@"檔案儲存失敗");
    }
    [saveArray release];
}
#pragma mark 載入儲存在本機端的所有timeCounterInfo
- (void)loadTimeRecord
{
    NSString *filePath = [[GlobalFunctions shareInstance] getDocumentFullPath:timeRecordFileName];
    allArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    //搜尋過瀘條件
    [self searchTimeArray];
    NSMutableArray *dateGroup = [[NSMutableArray alloc] init];
    NSLog(@"loadRecord:%@",allArray);
    //for (NSDictionary *dict in searchResultArray)
    for (timeCounterInfo *info in searchResultArray)
    {
        //timeCounterInfo *info = [[timeCounterInfo alloc] init];
        //info = [info createTimerWithInfo:dict];
        info.timeInterval = [DateFunction IntervalBetweenToday:[NSDate date] andDate:[DateFunction StringToDate:info.createTime] andEndDate:[DateFunction StringToDate:info.expireTime]];
        if ([sortType isEqualToString:sortByCategory])
        {
            NSMutableArray *itemArray = [[NSMutableArray alloc] initWithArray:[timerArray objectAtIndex:[info.category integerValue]]];
            [itemArray addObject:info];
            [timerArray replaceObjectAtIndex:[info.category integerValue] withObject:itemArray];
            [itemArray release];
        }
        else if ([sortType isEqualToString:sortByDate])
        {
            //依照 (年-月)  來建立郡組
            NSInteger ind = [dateGroup indexOfObject:[DateFunction GetYearAndMonthWithDate:info.createTime]];
            if (ind == NSNotFound)
            {
                [dateGroup addObject:[DateFunction GetYearAndMonthWithDate:info.createTime]];
            }
        }
        [info release];
    }
    if ([sortType isEqualToString:sortByDate])
    {
        //將建立好的群組重新排列
        dateGroupArray = [[NSArray alloc] initWithArray:dateGroup];
        dateGroupArray = [dateGroupArray sortedArrayUsingComparator:^(id obj1, id obj2)
                          {
                              NSString *s1 = (NSString*)obj1;
                              NSString *s2 = (NSString*)obj2;
                              return [s1 compare:s2];
                          }];
        [self makeDateTimerArray];
    }
    [dateGroup release];
}
#pragma mark 過濾搜尋條件
- (void)searchTimeArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in allArray)
    {
        timeCounterInfo *info = [[timeCounterInfo alloc] init];
        info = [info createTimerWithInfo:dict];
        //判斷是否有等於關鍵值的，共有四種情況
        /*
         NSString *seq;
         NSString *imageUrl;
         NSString *imageFilePath;
         NSString *category;
         NSString *categoryName;
         NSString *intro;
         NSString *createTime;
         NSString *expireTime;
         NSString *timeInterval;
         BOOL isNotify;
         */
        NSRange stringRange;
        if (searchKey != nil && ![searchKey isEqualToString:@""])
        {
            if (searchCategory != -1)
            {
                if ([info.category integerValue] == searchCategory)
                {
                    [array addObject:info];
                    continue;
                }
                else 
                {
                    continue;
                }
            }
            stringRange = [info.intro rangeOfString:searchKey];
            if (stringRange.location != NSNotFound)
            {
                [array addObject:info];
                continue;
            }
            stringRange = [info.categoryName rangeOfString:searchKey];
            if (stringRange.location != NSNotFound)
            {
                [array addObject:info];
                continue;
            }
            stringRange = [info.createTime rangeOfString:searchKey];
            if (stringRange.location != NSNotFound)
            {
                [array addObject:info];
                continue;
            }
            stringRange = [info.expireTime rangeOfString:searchKey];
            if (stringRange.location != NSNotFound)
            {
                [array addObject:info];
                continue;
            }
        }
        else if (searchKey == nil || [searchKey isEqualToString:@""])
        {
            if (searchCategory != -1)
            {
                if ([info.category integerValue] == searchCategory)
                {
                    [array addObject:info];
                    continue;
                }
                else
                {
                    continue;
                }
            }
            [array addObject:info];
        }
    }
    searchResultArray = [[NSArray alloc] initWithArray:array];
    [array release];
}
#pragma mark 建立依照分類空白資料
- (void)createTimerArray
{
    if ([sortType isEqualToString:sortByCategory])
    {
        timerArray = [[NSMutableArray alloc] initWithCapacity:[categoryArray count]];
        for (NSString* categoryName in categoryArray)
        {
            NSArray *itemArray = [[NSArray alloc] init];
            [timerArray addObject:itemArray];
            [itemArray release];
        }
    }
    else
    {
        timerArray = [[NSMutableArray alloc] init];
    }
}
#pragma mark 建立依照日期排序的資料
- (void)makeDateTimerArray
{
    //建立群組的資料集合
    for (NSString *str in dateGroupArray)
    {
        NSMutableArray *itemArray = [[NSMutableArray alloc] init];
        [timerArray addObject:itemArray];
        [itemArray release];
    }
    //將資料一筆一筆填入相對應的集合中
    //for (NSDictionary *dict in searchResultArray)
    for (timeCounterInfo *info in searchResultArray)
    {
        NSString *dateString = [DateFunction GetYearAndMonthWithDate:info.createTime];
        NSUInteger ind = [dateGroupArray indexOfObject:dateString];
        NSMutableArray *itemArray = [timerArray objectAtIndex:ind];
        //timeCounterInfo *info = [[timeCounterInfo alloc] init];
        //info = [info createTimerWithInfo:dict];
        info.timeInterval = [DateFunction IntervalBetweenToday:[NSDate date] andDate:[DateFunction StringToDate:info.createTime] andEndDate:[DateFunction StringToDate:info.expireTime]];
        [itemArray addObject:info];
        [timerArray replaceObjectAtIndex:ind withObject:itemArray];
        [info release];
    }
}
#pragma mark 新增一筆日期的group item
- (NSInteger)addDateGroupItem:(NSString*)dateString
{
    NSUInteger cnt = [dateGroupArray count] + 1;
    NSMutableArray *dateGroup = [[NSMutableArray alloc] initWithArray:dateGroupArray];
    [dateGroup addObject:dateString];
    dateGroupArray = [NSArray arrayWithArray:dateGroup];
    dateGroupArray = [dateGroupArray sortedArrayUsingComparator:^(id obj1, id obj2)
                      {
                          NSString *s1 = (NSString*)obj1;
                          NSString *s2 = (NSString*)obj2;
                          return [s1 compare:s2];
                      }];
    [dateGroup release];
    //timerArray 也要新增一筆
    [timerArray addObject:[[NSMutableArray alloc] init]];
    return cnt - 1;
}

@end
