//
//  TXTBookDataSource.m
//  EBookStore
//
//  Created by 李巍 on 15/5/13.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "TXTBookDataSource.h"

@interface TXTBookDataSource ()

@property (strong, nonatomic) NSTextStorage   *textStorage;
@property (strong, nonatomic) NSLayoutManager *contentLayoutManager;
@property (strong, nonatomic) NSMutableArray  *pageContainers;

@end

@implementation TXTBookDataSource

+ (instancetype)sharedInstance {
	static dispatch_once_t pred = 0;
	__strong static id _sharedObject = nil;
	dispatch_once(&pred, ^{
		_sharedObject = [[self alloc] init];
	});
	return _sharedObject;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		
	}
	return self;
}

#pragma mark -

- (void)setupWithBook:(EBookModel *)model {
	self.eBook = model;
	if (!self.pageContainers) {
		self.pageContainers = [[NSMutableArray alloc] initWithCapacity:20];
	}
	self.textStorage = [[NSTextStorage alloc] initWithString:[self loadTXTBookWithName:model.title]];
	[self.textStorage addAttributes:[self contentAttributes] range:NSMakeRange(0, [self.textStorage.string length])];
	self.contentLayoutManager = [[NSLayoutManager alloc] init];
	[self.textStorage addLayoutManager:self.contentLayoutManager];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"BookDataIsRedeyForShowNotification" object:nil];
}

- (void)restore {
	[self.pageContainers removeAllObjects];
	self.textStorage = nil;
	self.contentLayoutManager = nil;
}

- (NSString *)loadTXTBookWithName:(NSString *)bName {
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSError *error = nil;
	NSString *string = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:bName ofType:@"txt"] encoding:enc error:&error];
	if (error) {
		NSLog(@"page data error = %@", [error localizedDescription]);
		string = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:bName ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
	}
	return string;
}





- (NSTextContainer *)calculatePageContainerAtIndex:(NSInteger)index withContainerSize:(CGSize)size {
	for (int i = 0; i <= index; i++) {
		if (i >= [self.pageContainers count]) {
			NSTextContainer *container = [[NSTextContainer alloc] initWithSize:size];
			[self.contentLayoutManager addTextContainer:container];
			[self.pageContainers addObject:container];
		}
	}
	return self.pageContainers[index];
}

- (NSAttributedString *)contentAtPageIndex:(NSInteger)index withContainerSize:(CGSize)size {
	NSTextContainer *container = [self calculatePageContainerAtIndex:index withContainerSize:size];
	NSRange range = [self.contentLayoutManager glyphRangeForTextContainer:container];
	return [self.textStorage attributedSubstringFromRange:range];
}

- (NSUInteger)maxPageCount {
	NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake([[UIScreen mainScreen] applicationFrame].size.width, FLT_MAX)];
	[self.contentLayoutManager addTextContainer:container];
	CGRect frame = [self.contentLayoutManager boundingRectForGlyphRange:NSMakeRange(0, [self.contentLayoutManager numberOfGlyphs]) inTextContainer:container];
	[self.contentLayoutManager removeTextContainerAtIndex:[self.contentLayoutManager.textContainers count] - 1];
	NSUInteger maxPageCount = frame.size.height / [[UIScreen mainScreen] applicationFrame].size.height + 1;
	return maxPageCount;
}

- (NSDictionary *)contentAttributes {
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineHeightMultiple  = 1.f;                    // 可变行高,乘因数
	paragraphStyle.lineSpacing         = 5.f;                    // 行间距
	paragraphStyle.minimumLineHeight   = 10.f;                   // 最小行高
	paragraphStyle.maximumLineHeight   = 20.f;                   // 最大行高
	paragraphStyle.paragraphSpacing    = 10.f;                   // 段间距
	paragraphStyle.alignment           = NSTextAlignmentLeft;    // 对齐方式
	paragraphStyle.firstLineHeadIndent = 0.f;                   // 段落首文字离边缘间距
	paragraphStyle.headIndent          = 0.f;                    // 段落除了第一行的其他文字离边缘间距
	paragraphStyle.tailIndent          = 0.f;                    // ???????
	
	//	NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont fontWithName:@"Snell Roundhand" size:16.0f], NSForegroundColorAttributeName:[UIColor blackColor]};
	NSDictionary *attributes = @{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName:[UIFont systemFontOfSize:16.0f], NSForegroundColorAttributeName:[UIColor blackColor]};
	return attributes;
}

@end
