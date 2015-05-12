//
//  BookContentView.m
//  JinyongAllInOne
//
//  Created by 李巍 on 15/3/9.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "BookContentView.h"

@interface BookContentView () <UITextViewDelegate>

@end

@implementation BookContentView

- (void)awakeFromNib {
	[super awakeFromNib];
	// 边距
	self.textContainerInset = UIEdgeInsetsMake(40, 20, 20, 20);
}

@end
