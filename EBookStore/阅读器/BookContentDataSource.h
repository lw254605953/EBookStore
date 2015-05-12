//
//  BookContentDataSource.h
//  JinyongAllInOne
//
//  Created by 李巍 on 15/3/11.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EBookModel.h"

@interface BookContentDataSource : NSObject

+ (instancetype)sharedInstance;

- (void)setupWithBook:(EBookModel *)model;

- (void)restore;


- (NSAttributedString *)contentAtPageIndex:(NSInteger)index withContainerSize:(CGSize)size;

- (NSDictionary *)contentAttributes;

- (NSUInteger)maxPageCount;

@property (strong, nonatomic) EBookModel *eBook;

@end
