//
//  BookShelfCollectionViewLayout.m
//  JinyongAllInOne
//
//  Created by 李巍 on 15/4/17.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "BookShelfCollectionViewLayout.h"
#import "BookShelfViewLayoutAttributes.h"
#import "BookShelfDecorationView.h"

@interface BookShelfCollectionViewLayout ()

@property (nonatomic, strong) NSDictionary *shelfRects;

@end

@implementation BookShelfCollectionViewLayout

+ (Class)layoutAttributesClass {
	return [BookShelfViewLayoutAttributes class];
}

- (void)awakeFromNib {
	[super awakeFromNib];
}

- (void)prepareLayout {
	[super prepareLayout];
    [self registerClass:[BookShelfDecorationView class] forDecorationViewOfKind:@"BookShelfDecorationView"];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *allAttributes = [super layoutAttributesForElementsInRect:rect];
	NSMutableArray *attributes = [NSMutableArray arrayWithArray:allAttributes];
    for (UICollectionViewLayoutAttributes *attribute in allAttributes) {
        if (attribute.representedElementKind == UICollectionElementCategoryCell) {
            BookShelfViewLayoutAttributes *decorationAttributes = (BookShelfViewLayoutAttributes *)[self layoutAttributesForDecorationViewOfKind:@"BookShelfDecorationView" atIndexPath:attribute.indexPath];
            decorationAttributes.frame = CGRectMake(0, (attribute.indexPath.item / 3) * CGRectGetHeight(attribute.frame), CGRectGetWidth([[UIScreen mainScreen] applicationFrame]), CGRectGetHeight(attribute.frame));
            decorationAttributes.zIndex = -1;
            decorationAttributes.indexPath = attribute.indexPath;
            [attributes addObject:decorationAttributes];
        }
    }
	return attributes;
}

- (BookShelfViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    BookShelfViewLayoutAttributes *attributes = [BookShelfViewLayoutAttributes layoutAttributesForDecorationViewOfKind:elementKind withIndexPath:indexPath];
    return attributes;
}


@end
