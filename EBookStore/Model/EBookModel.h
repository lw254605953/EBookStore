//
//  EBookModel.h
//  EBookStore
//
//  Created by 李巍 on 15/5/12.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/MTLJSONAdapter.h>
#import <Mantle/MTLManagedObjectAdapter.h>

typedef NS_ENUM(NSInteger, EBookType) {
    EBookTypeWuxia = 0,
    EBookTypeYanqing,
    EBookTypeXuanhuan,
    EBookTypeKongbu
};

typedef NS_ENUM(NSInteger, EBookFileType) {
	EBookFileTypeTXT = 0,
	EBookFileTypePDF,
	EBookFileTypeEPub,
	EBookFileTypeWord
};

@interface EBookModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

/*!
 *  @author Megatron, 2015-05-11
 *
 *  @brief  书籍ID
 */
@property (nonatomic, strong) NSString * identifier;
/*!
 *  @author Megatron, 2015-05-11
 *
 *  @brief  书名
 */
@property (nonatomic, strong) NSString * title;
/*!
 *  @author Megatron, 2015-05-11
 *
 *  @brief  封面图片
 */
@property (nonatomic, strong) NSString * coverImage;
/*!
 *  @author Megatron, 2015-05-11
 *
 *  @brief  用户当前阅读页数
 */
@property (assign, nonatomic) NSInteger currentPage;
/*!
 *  @author Megatron, 2015-05-11
 *
 *  @brief  书籍总页数
 */
@property (assign, nonatomic) NSInteger maxPageCount;
/*!
 *  @author Megatron, 2015-05-11
 *
 *  @brief  作者
 */
@property (nonatomic, strong) NSString * author;
/*!
 *  @author Megatron, 2015-05-11
 *
 *  @brief  书籍类型
 */
@property (assign, nonatomic) EBookType type;

/*!
 *  @author Megatron, 2015-05-11
 *
 *  @brief  书文件类型
 */
@property (assign, nonatomic) EBookFileType filetype;

+ (NSString *)entityName;

@end
