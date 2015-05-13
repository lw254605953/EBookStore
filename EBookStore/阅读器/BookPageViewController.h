//
//  BookPageViewController.h
//  BookStore
//
//  Created by 李巍 on 15/1/21.
//  Copyright (c) 2015年 LW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookPageViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

- (void)setupWithFirstPage:(NSInteger)pageIndex;

@end
