//
//  BookShelfDecorationView.m
//  JinyongAllInOne
//
//  Created by 李巍 on 15/4/17.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "BookShelfDecorationView.h"

@implementation BookShelfDecorationView

- (UIImageView *)bgView {
	if (_bgView == nil) {
		_bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BookShelfCellBg"]];
		[self addSubview:_bgView];
	}
	return _bgView;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
	self.bgView.frame = layoutAttributes.bounds;
}

@end
