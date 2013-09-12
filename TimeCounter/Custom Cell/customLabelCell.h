//
//  customLabelCell.h
//  TimeCounter
//
//  Created by 張星星 on 12/4/26.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customLabelCell : UITableViewCell
{
    UILabel *titleLabel;
    UILabel *contentLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *contentLabel;
@end
