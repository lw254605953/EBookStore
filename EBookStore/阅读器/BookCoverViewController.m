//
//  BookCoverViewController.m
//  EBookStore
//
//  Created by 李巍 on 15/5/13.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "BookCoverViewController.h"
#import "MacroDefinition.h"
#import "BookNavBarView.h"
#import "BookContentDataSource.h"

@interface BookCoverViewController () <BookNavBarViewProtocol>

@property (strong, nonatomic) BookNavBarView *navView;

@end

@implementation BookCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	BookNavBarView *nav = [[BookNavBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
	nav.delegate = self;
	[self.view addSubview:nav];
	self.navView = nav;
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapContent:)];
	[self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
	[[BookContentDataSource sharedInstance] restore];
	[self dismissViewControllerAnimated:YES completion:NULL];
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
