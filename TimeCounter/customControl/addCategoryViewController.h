//
//  addCategoryViewController.h
//  TimeCounter
//
//  Created by 張星星 on 12/5/9.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class addCategoryViewController;
@protocol addCategoryDelegate <NSObject>

- (void)addCategoryView:(addCategoryViewController*)view didAddCategory:(NSString*)categoryName;
- (void)addCategoryView:(addCategoryViewController*)view didModifyCategory:(NSString*)categoryName andIndexPath:(NSIndexPath*)indexPath;

@end

@interface addCategoryViewController : UIViewController <UITextViewDelegate>
{
    IBOutlet UIToolbar *toolBar;
    IBOutlet UITextView *textView;
    NSString *currentCategoryName;
    BOOL isModify;
    NSIndexPath *modifyIndexPath;
    id<addCategoryDelegate> delegate;
}
@property (assign) id<addCategoryDelegate> delegate;
@property (nonatomic, retain) NSString *currentCategoryName;
@property (nonatomic) BOOL isModify;
@property (nonatomic, retain) NSIndexPath *modifyIndexPath;

@end
