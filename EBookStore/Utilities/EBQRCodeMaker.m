//
//  EBQRCodeMaker.m
//  BusinessClient
//
//  Created by 李巍 on 15/4/29.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "EBQRCodeMaker.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

@implementation EBQRCodeMaker

- (UIImage *)encodeWithString:(NSString *)string imageSize:(CGSize)size {
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *image = [self createQRFromData:data withSize:CGSizeMake(size.width, size.width)];
	return image;
}

- (UIImage *)encodeWithDictionary:(NSDictionary *)dictionary imageSize:(CGSize)size {
	NSError *error = nil;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
	if (error) {
		DDLogDebug(@"transform json dictionary to data error = %@", error);
	}
	UIImage *image = [self createQRFromData:jsonData withSize:CGSizeMake(size.width, size.width)];
	return image;
}


- (UIImage *)createQRFromData:(NSData *)data withSize:(CGSize)size {
	CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
	[filter setDefaults];
	[filter setValue:data forKey:@"inputMessage"];
	
	CIImage *outputImage = [filter outputImage];
	
	CIContext *context = [CIContext contextWithOptions:nil];
	CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
	
	UIImage *barcode = [UIImage imageWithCGImage:cgImage];
	
	UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
	CGContextRef cgcontext = UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(cgcontext, kCGInterpolationNone);
	[barcode drawInRect:CGRectMake(0, 0, size.width, size.height)];
	UIImage *image_out = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	//將 image_qr 縮放成符合 UIImageView 的大小
	return image_out;
}


@end
