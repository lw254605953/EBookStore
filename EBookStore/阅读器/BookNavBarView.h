//
//  BookNavBarView.h
//  JinyongAllInOne
//
//  Created by 李巍 on 15/5/11.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookNavBarViewProtocol <NSObject>

- (void)backAction;

@end

@interface BookNavBarView : UIView

@property (assign, nonatomic) id<BookNavBarViewProtocol> delegate;

@end
