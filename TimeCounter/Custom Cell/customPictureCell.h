//
//  customPictureCell.h
//  TimeCounter
//
//  Created by 張星星 on 12/4/13.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Resize.h"

enum
{
    customPictureCellButtonTypeTakeNewPicture = 0,
    customPictureCellButtonTypeViewLarge = 1
};
typedef NSInteger customPictureCellButtonType;

@class customPictureCell;
@protocol pictureCellDelegate <NSObject>

- (void)customPictureCell:(customPictureCell*)cell didPressButton:(customPictureCellButtonType)buttonType;

@end

@interface customPictureCell : UITableViewCell
{
    id<pictureCellDelegate> delegate;
    UIImageView *myImageView;
    UILabel *timeIntervalLabel;
}

@property (assign) id<pictureCellDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *myImageView;
@property (nonatomic, retain) IBOutlet UILabel *timeIntervalLabel;

- (IBAction)takePicturePress;
- (IBAction)viewLargePicture;

- (void)setImageWithPath:(NSString*)imagePath;

@end
