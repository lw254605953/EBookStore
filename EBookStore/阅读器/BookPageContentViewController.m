//
//  BookPageContentViewController.m
//  BookStore
//
//  Created by 李巍 on 15/2/5.
//  Copyright (c) 2015年 LW. All rights reserved.
//

#import "BookPageContentViewController.h"
#import "BookNavBarView.h"
#import "BookContentDataSource.h"

#import "MacroDefinition.h"

@interface BookPageContentViewController () <BookNavBarViewProtocol>

@property (strong, nonatomic) BookNavBarView *navView;

@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@end

@implementation BookPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	BookNavBarView *nav = [[BookNavBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
	nav.delegate = self;
	[self.view addSubview:nav];
	self.navView = nav;
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContent:)];
	[self.view addGestureRecognizer:tapGesture];
	
	self.pageLabel.text = [NSString stringWithFormat:@"第  %zd  页", self.pageIndex];
    if (self.pageIndex == 0) {
        self.pageLabel.text = @"封面";
    }
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	[self showPageContent];
}

- (void)showPageContent {
	// 设置内容
	[self.contentView.textStorage setAttributedString:[[BookContentDataSource sharedInstance] contentAtPageIndex:self.pageIndex withContainerSize:self.contentView.textContainer.size]];
}

- (void)tapContent:(UITapGestureRecognizer *)tap {
	CGPoint touchPoint = [tap locationInView:self.view];
	CGRect rect = CGRectMake(20, 40, self.view.frame.size.width - 20*2, self.view.frame.size.height - 40 - 20);
	if (CGRectContainsPoint(rect, touchPoint)) {
		[UIView animateWithDuration:0.4 animations:^{
			CGRect frame = self.navView.frame;
			if (frame.size.height == 0) {
				frame.size.height = 64;
				[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//				[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
			}else {
				frame.size.height = 0;
				[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
			}
			self.navView.frame = frame;
		} completion:NULL];
	}
}

- (void)backAction {
	[[BookContentDataSource sharedInstance] restore];
	[self dismissViewControllerAnimated:YES completion:NULL];
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

@end
