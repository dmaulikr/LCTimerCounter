//
//  CustomNavgationBar.m
//  MercuriesLife
//
//  Created by Eric Lin on 2010/9/24.
//  Copyright 2010 EraSoft. All rights reserved.
//

#import "CustomNavgationBar.h"

@implementation UINavigationBar (UINavigationBarCategory)

/*
 	自定 Navigation bar
 */

-(void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	[self setTintColor:navigationBarButtonColor];
	UIImage *img = [UIImage imageNamed:navigationBarBackground];
    [img drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

@end