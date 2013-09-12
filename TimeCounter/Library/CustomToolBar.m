//
//  CustomToolBar.m
//  ClockReminder
//
//  Created by 張星星 on 11/12/21.
//  Copyright (c) 2011年 星星. All rights reserved.
//

#import "CustomToolBar.h"

@implementation UIToolbar (UIToolBarCategory)

-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	[self setTintColor:toolBarButtonColor];
	UIImage *img = [UIImage imageNamed:navigationBarBackground];
    [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end
