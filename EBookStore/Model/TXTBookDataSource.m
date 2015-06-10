//
//  TXTBookDataSource.m
//  EBookStore
//
//  Created by 李巍 on 15/5/13.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "TXTBookDataSource.h"
#import "MacroDefinition.h"
#import "CoreDataManager.h"

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
		self.pageContainers = [[NSMutableArray alloc] initWithCapacity:100];
	}
	self.textStorage = [[NSTextStorage alloc] initWithString:[self loadTXTBookWithName:model.title]];
	[self.textStorage addAttributes:[self contentAttributes] range:NSMakeRange(0, [self.textStorage.string length])];
	self.contentLayoutManager = [[NSLayoutManager alloc] init];
	[self.textStorage addLayoutManager:self.contentLayoutManager];

	[self layoutTextContainers];

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

- (void)layoutTextContainers {
	NSUInteger lastRenderedGlyph = 0;
	CGFloat currentXOffset = 0;
	while (lastRenderedGlyph < self.contentLayoutManager.numberOfGlyphs) {
		CGRect textViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		CGSize columnSize = [self bookContentSize];
		
		NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:columnSize];
		[self.contentLayoutManager addTextContainer:textContainer];
		[self.pageContainers addObject:textContainer];
		
		// Increase the current offset
		currentXOffset += CGRectGetWidth(textViewFrame);
		
		// And find the index of the glyph we've just rendered
		lastRenderedGlyph = NSMaxRange([self.contentLayoutManager glyphRangeForTextContainer:textContainer]);
	}
}

- (NSAttributedString *)contentAtPageIndex:(NSInteger)index {
	NSTextContainer *container = self.pageContainers[index];
	NSRange range = [self.contentLayoutManager glyphRangeForTextContainer:container];
	return [self.textStorage attributedSubstringFromRange:range];
}

- (NSUInteger)maxPageCount {
    if (self.eBook.maxPageCount > 0) {
        return self.eBook.maxPageCount;
    }
	self.eBook.maxPageCount = [self.pageContainers count];
	[[CoreDataManager sharedInstance] updateModel:self.eBook];
	
	return self.eBook.maxPageCount;
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

- (CGSize)bookContentSize {
    return CGSizeMake(SCREEN_WIDTH - 20 - 20, SCREEN_HEIGHT - 40 - 20 - BookContentLineMargin);
}

@end
