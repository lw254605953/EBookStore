//
//  BookCoverView.m
//  EBookStore
//
//  Created by 李巍 on 15/5/13.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "BookCoverView.h"
#import "BookContentDataSource.h"

@implementation BookCoverView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	// 根据上下文写字
	UIColor *magentaColor = [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0f];
	[magentaColor set];
	UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f];
	NSString *myString = [BookContentDataSource sharedInstance].eBook.title;
	[myString drawInRect:CGRectMake(25, 100, self.frame.size.width - 50, 40) withAttributes:@{NSFontAttributeName:helveticaBold, NSForegroundColorAttributeName:magentaColor}];
}


@end
