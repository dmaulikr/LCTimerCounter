//
//  customTextFieldCell.m
//  TimeCounter
//
//  Created by 張星星 on 12/4/26.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customTextFieldCell.h"

@implementation customTextFieldCell
@synthesize titleLabel, contentTextField;

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

@end
