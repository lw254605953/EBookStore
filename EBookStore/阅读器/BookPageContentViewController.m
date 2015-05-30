//
//  BookPageContentViewController.m
//  BookStore
//
//  Created by 李巍 on 15/2/5.
//  Copyright (c) 2015年 LW. All rights reserved.
//

#import "BookPageContentViewController.h"
#import "BookNavBarView.h"
#import "TXTBookDataSource.h"

#import "MacroDefinition.h"

@interface BookPageContentViewController () <BookNavBarViewProtocol>

@property (strong, nonatomic) BookNavBarView *navView;

@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@property (assign, nonatomic) BOOL isShowText;

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
	self.isShowText = NO;
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	CGRect frame = self.contentView.frame;
	if (frame.origin.y == -20) {
		frame.origin.y = 0;
		frame.size.height -= 20;
		self.contentView.frame = frame;
	}
	if (!self.isShowText) {
		[self showTXTPageContent];
	}
}

- (void)showTXTPageContent {
	// 设置内容
	[self.contentView.textStorage setAttributedString:[[TXTBookDataSource sharedInstance] contentAtPageIndex:self.pageIndex - 1]];
//    NSLog(@"1 w = %f h = %f,  2 w = %f h = %f", self.contentView.textContainer.size.width, self.contentView.textContainer.size.height, SCREEN_WIDTH - 40, SCREEN_HEIGHT - 60);
	self.isShowText = YES;
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
				[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
			}else {
				frame.size.height = 0;
				[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
			}
			self.navView.frame = frame;
		} completion:NULL];
	}
}

- (void)backAction {
	[[TXTBookDataSource sharedInstance] restore];
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
