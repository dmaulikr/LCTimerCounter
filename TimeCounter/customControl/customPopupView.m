//
//  customPopupView.m
//  TimeCounter
//
//  Created by 張星星 on 12/5/9.
//  Copyright (c) 2012年 Mountain Star Smart. All rights reserved.
//

#import "customPopupView.h"

@implementation customPopupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Set the fill color
	[[UIColor lightGrayColor] setFill];
    
    // Create the path for the rounded rectanble
    CGRect roundedRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height * 0.8);
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:6.0];
    
    // Create the arrow path
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    //CGFloat midX = CGRectGetMidX(self.bounds);
    //CGPoint p0 = CGPointMake(midX, CGRectGetMaxY(self.bounds));
    CGPoint p0 = CGPointMake(30, CGRectGetMaxY(self.bounds));
    [arrowPath moveToPoint:p0];
    //[arrowPath addLineToPoint:CGPointMake((midX - 10.0), CGRectGetMaxY(roundedRect))];
    //[arrowPath addLineToPoint:CGPointMake((midX + 10.0), CGRectGetMaxY(roundedRect))];
    [arrowPath addLineToPoint:CGPointMake(20, CGRectGetMaxY(roundedRect))];
    [arrowPath addLineToPoint:CGPointMake(40, CGRectGetMaxY(roundedRect))];
    [arrowPath closePath];
    
    // Attach the arrow path to the rounded rectangle
    [roundedRectPath appendPath:arrowPath];
    
    [roundedRectPath fill];
}


@end
