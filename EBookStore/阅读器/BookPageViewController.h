//
//  BookPageViewController.h
//  BookStore
//
//  Created by 李巍 on 15/1/21.
//  Copyright (c) 2015年 LW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EBook;

@interface BookPageViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) EBook *eBook;

- (void)setupWithFirstPage:(NSInteger)pageIndex;

@end
