//
//  BookNavBarView.m
//  JinyongAllInOne
//
//  Created by 李巍 on 15/5/11.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "BookNavBarView.h"

@implementation BookNavBarView
{
	UIButton *back;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
		self.exclusiveTouch = YES;
		back = [UIButton buttonWithType:UIButtonTypeCustom];
		[back setImage:[UIImage imageNamed:@"back_button_down"] forState:UIControlStateNormal];
		[back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[back setFrame:CGRectMake(10, 20, 44, 44)];
		[back addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:back];
		
		self.clipsToBounds = YES;
	}
	return self;
}

- (void)goBackAction {
	if (self.delegate) {
		[self.delegate backAction];
	}
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	[back setFrame:CGRectMake(15, 31, 22, 22)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
