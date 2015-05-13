//
//  BookShelfViewController.m
//  JinyongAllInOne
//
//  Created by 李巍 on 15/4/17.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "BookShelfViewController.h"
#import "BookShelfCollectionView.h"
#import "BookShelfCollectionViewCell.h"

#import "BookMasterViewController.h"
#import "BookContentDataSource.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "EBookModel.h"
#import "CoreDataManager.h"

@interface BookShelfViewController ()

@property (weak, nonatomic) IBOutlet BookShelfCollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation BookShelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	UINib *cellNib = [UINib nibWithNibName:@"BookShelfCollectionViewCell" bundle:nil];
	[self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
	
	NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"]];
	self.books = [array mutableCopy];
	self.searchResults = [array mutableCopy];

	[self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self.searchResults count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	BookShelfCollectionViewCell *cell = (BookShelfCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	NSDictionary *book = self.searchResults[indexPath.item];
	cell.coverImageView.image = [UIImage imageNamed:book[@"img"]];
	if ([book[@"img"] length] == 0) {
		cell.bookNameLabel.text = book[@"title"];
	}else {
		cell.bookNameLabel.text = @"";
	}
	return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	__weak typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSDictionary *book = weakSelf.searchResults[indexPath.item];
		EBookModel *eBook = [[CoreDataManager sharedInstance] fetchEBookWithBookIdentifier:book[@"id"]];
		if (eBook == nil) {
			[[CoreDataManager sharedInstance] insertModelWithJSON:book];
			eBook = [[CoreDataManager sharedInstance] fetchEBookWithBookIdentifier:book[@"id"]];
		}
		[[BookContentDataSource sharedInstance] setupWithBook:eBook];
	});
	if ([self.searchBar isFirstResponder]) {
		[self.searchBar resignFirstResponder];
	}
	[SVProgressHUD showWithStatus:@"正在读取数据"];
    BookMasterViewController *master = [self.storyboard instantiateViewControllerWithIdentifier:@"BookMasterViewController"];
	[self presentViewController:master animated:YES completion:^{
		[SVProgressHUD dismiss];
	}];
}


#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:NO animated:YES];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
	[self filterContentForSearchText:searchBar.text scope:nil];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
	if ([searchBar.text length] == 0) {
		self.searchResults = [self.books mutableCopy];
		[self.collectionView reloadData];
	}
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
	// [cd] 忽略大小写
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText];
	self.searchResults = [[self.books filteredArrayUsingPredicate:predicate] mutableCopy];
	[self.collectionView reloadData];
}

@end
