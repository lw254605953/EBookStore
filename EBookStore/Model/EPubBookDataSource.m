//
//  EPubBookDataSource.m
//  EBookStore
//
//  Created by 李巍 on 15/5/13.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "EPubBookDataSource.h"

@implementation EPubBookDataSource

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

- (NSString *)loadEPubBookWithName:(NSString *)bName {
	return @"";
}

@end
