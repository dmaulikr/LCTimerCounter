//
//  customPictureCell.m
//  TimeCounter
//
//  Created by 張星星 on 12/4/13.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customPictureCell.h"

@implementation customPictureCell

@synthesize delegate, myImageView, timeIntervalLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //UITouch *touch = [touches anyObject];
}

- (void)setImageWithPath:(NSString*)imagePath
{
    //11, 7,  280,192
    UIImage *imageObj = [UIImage imageWithContentsOfFile:imagePath];
    NSData *data = UIImagePNGRepresentation(imageObj);
    NSLog(@"imageSize:%i",data.length);
    if ([data length] > 2000000)
        imageObj = [imageObj imageByScalingToSize:CGSizeMake(300, 200)];
    [myImageView setImage:imageObj];
    imageObj = nil;
    data = nil;
}

- (IBAction)takePicturePress
{
    [delegate customPictureCell:self didPressButton:customPictureCellButtonTypeTakeNewPicture];
}
- (IBAction)viewLargePicture
{
    [delegate customPictureCell:self didPressButton:customPictureCellButtonTypeViewLarge];
}

@end
