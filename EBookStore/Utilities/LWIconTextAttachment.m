//
//  LWIconTextAttachment.m
//  BusinessClient
//
//  Created by 李巍 on 15/5/7.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "LWIconTextAttachment.h"

@implementation LWIconTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex NS_AVAILABLE_IOS(7_0) {
    
    CGRect rect = [super attachmentBoundsForTextContainer:textContainer proposedLineFragment:lineFrag glyphPosition:position characterIndex:charIndex];
    rect.origin.y -=2.5;
    rect.origin.x += 2;
    return rect;
}

@end
