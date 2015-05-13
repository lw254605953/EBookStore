//
//  TXTBookDataSource.h
//  EBookStore
//
//  Created by 李巍 on 15/5/13.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EBookModel.h"

@interface TXTBookDataSource : NSObject

+ (instancetype)sharedInstance;

- (void)setupWithBook:(EBookModel *)model;

- (void)restore;


- (NSAttributedString *)contentAtPageIndex:(NSInteger)index withContainerSize:(CGSize)size;

- (NSDictionary *)contentAttributes;

- (NSUInteger)maxPageCount;

@property (strong, nonatomic) EBookModel *eBook;

@end
