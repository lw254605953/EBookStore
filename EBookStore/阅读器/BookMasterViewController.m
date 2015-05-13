//
//  BookMasterViewController.m
//  JinyongAllInOne
//
//  Created by 李巍 on 15/3/9.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "BookMasterViewController.h"
#import "BookPageViewController.h"
#import "BookPageContentViewController.h"

#import "EBookModel.h"
#import "BookContentDataSource.h"

@interface BookMasterViewController ()

@property (strong, nonatomic) BookPageViewController *pageViewController;

@end

@implementation BookMasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showReaderContent:) name:@"BookDataIsRedeyForShowNotification" object:nil];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"BookDataIsRedeyForShowNotification" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageViewController = [self.childViewControllers firstObject];
	self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showReaderContent:(NSNotification *)notification {
	if (self.pageViewController == nil) {
		self.pageViewController = [self.childViewControllers firstObject];
	}
	__weak typeof(self) weakSelf = self;
	dispatch_async(dispatch_get_main_queue(), ^{
		[weakSelf.pageViewController setupWithFirstPage:[BookContentDataSource sharedInstance].eBook.currentPage];
	});
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
