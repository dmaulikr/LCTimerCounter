//
//  AboutViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/5/6.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

enum
{
    aboutFunctionTypeFeedback = 0,
    aboutFunctionTypeIntroduction = 1,
    aboutFunctionTypeCopyright = 2,
};
typedef NSUInteger aboutFunctionType;

enum
{
    feedBackRowRateUs = 0,
    feedBackRowTellFriend = 1,
    feedBackRowTellUs = 2,
};
typedef NSUInteger feedBackRow;

@interface AboutViewController : UITableViewController <MFMailComposeViewControllerDelegate>
{
    NSArray *functionArray;
    NSArray *feedBackArray;
    NSArray *introductionArray;
    NSArray *copyRightArray;
}

@end
