//
//  BookPageViewController.m
//  BookStore
//
//  Created by 李巍 on 15/1/21.
//  Copyright (c) 2015年 LW. All rights reserved.
//

#import "BookPageViewController.h"
#import "BookPageContentViewController.h"
#import "BookContentDataSource.h"
#import <SVProgressHUD/SVProgressHUD.h>

#import "EBookModel.h"
#import "CoreDataManager.h"

@interface BookPageViewController ()

@property (strong, nonatomic) EBookModel *eBook;

@property (assign, nonatomic) NSInteger maxPageCount;

@property (assign, nonatomic) NSInteger currentPageIndex;
@property (assign, nonatomic) NSInteger templePageIndex;

@end

@implementation BookPageViewController

- (void)awakeFromNib {
    [super awakeFromNib];
	self.delegate = self;
	self.dataSource = self;
	self.maxPageCount = [[BookContentDataSource sharedInstance] maxPageCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWithFirstPage:[BookContentDataSource sharedInstance].eBook.currentPage];
}

- (void)setupWithFirstPage:(NSInteger)pageIndex {
	//从第一页开始计算页码，但是封面是第0页
	self.currentPageIndex = pageIndex;
	self.templePageIndex = pageIndex;
	// 设置书籍的第一页
	[self setViewControllers:@[[self bookContentControllerAtIndex:pageIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
		
	}];
}

- (void)setCurrentPageIndex:(NSInteger)currentPageIndex {
	_currentPageIndex = currentPageIndex;
    
    EBookModel *model = [BookContentDataSource sharedInstance].eBook;
    model.currentPage = currentPageIndex;
	[[CoreDataManager sharedInstance] updateModel:model];
}

#pragma mark -

- (BookPageContentViewController *)bookContentControllerAtIndex:(NSUInteger)index {
	self.templePageIndex = index;
	BookPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BookPageContentViewController"];
	pageContentViewController.pageIndex = index;
	return pageContentViewController;
}

#pragma mark - UIPageViewControllerDataSource

// 返回前一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
	
	NSUInteger index = [self presentationIndexForPageViewController:pageViewController];
	if ((index == 0) || (index == NSNotFound)) {
		[SVProgressHUD showInfoWithStatus:@"已经是第一页"];
		return nil;
	}
	index--;
	return [self bookContentControllerAtIndex:index];
}

// 翻到下一页
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
	NSUInteger index = [self presentationIndexForPageViewController:pageViewController];
	if (index == [self presentationCountForPageViewController:pageViewController]) {
		[SVProgressHUD showInfoWithStatus:@"已经是最后一页"];
		return nil;
	}
	index++;
	return [self bookContentControllerAtIndex:index];
}

// 总页数
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
	return self.maxPageCount;
}

// 当前页码
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
	return self.currentPageIndex;
}


#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
//	_pageIsAnimating = NO;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
	
	if (completed) {
		//翻页完成
		self.currentPageIndex = self.templePageIndex;
		
	}else{ //翻页未完成 又回来了。
		if (NO) {
			//往右翻 且正好跨章节
		}else if (NO) {
			//往左翻 且正好跨章节
		}
	}
}

@end
