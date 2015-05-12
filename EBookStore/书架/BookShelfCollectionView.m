//
//  BookShelfCollectionView.m
//  JinyongAllInOne
//
//  Created by 李巍 on 15/4/17.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "BookShelfCollectionView.h"
#import "BookShelfCollectionViewLayout.h"

@implementation BookShelfCollectionView

- (void)awakeFromNib {
	[super awakeFromNib];
	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BookShelfBg"]];
	
	BookShelfCollectionViewLayout *layout = (BookShelfCollectionViewLayout *)self.collectionViewLayout;
	layout.numberOfItemsPerLine = 3;
	layout.aspectRatio = 4.0 / 5.0;
	layout.interitemSpacing = 0;
	layout.lineSpacing = 0;	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
