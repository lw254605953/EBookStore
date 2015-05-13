//
//  EBQRCodeMaker.h
//  BusinessClient
//
//  Created by 李巍 on 15/4/29.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EBQRCodeMaker : NSObject

/*!
 *  @author Megatron, 2015-04-29
 *
 *  @brief  根据字符串生成二维码，编码格式为UTF-8
 *
 *  @param string 编码字符串
 *  @param size   图片尺寸
 *
 *  @return 生成的二维码图片
 */
- (UIImage *)encodeWithString:(NSString *)string imageSize:(CGSize)size;

/*!
 *  @author Megatron, 2015-04-29
 *
 *  @brief  根据JSON数据生成二维码，编码格式为UTF-8
 *
 *  @param data JSON词典
 *  @param size 图片尺寸
 *
 *  @return 生成的二维码图片
 */
- (UIImage *)createQRFromData:(NSData *)data withSize:(CGSize)size;

@end
