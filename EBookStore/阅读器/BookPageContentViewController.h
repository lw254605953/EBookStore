//
//  BookPageContentViewController.h
//  BookStore
//
//  Created by 李巍 on 15/2/5.
//  Copyright (c) 2015年 LW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookContentView.h"

@interface BookPageContentViewController : UIViewController

@property (strong, nonatomic) IBOutlet BookContentView *contentView;

@property (assign, nonatomic) NSInteger pageIndex;

@end
