//
//  MacroDefinition.h
//  BusinessClient
//
//  Created by 李巍 on 15/5/2.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#ifndef BusinessClient_MacroDefinition_h
#define BusinessClient_MacroDefinition_h

// -----------------自定义-------------------

#define DEFAULT_FIRST_PAGE_INDEX 1
#define DEFAULT_DATA_COUNT_PER_PAGE 20

// ---------------- 颜色 --------------------
#pragma mark -
#pragma mark 颜色类

/**
 * RGB颜色转换（16进制->10进制）
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,f) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:f]

/**
 * RGB颜色转换
 */
#define UIColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/**
 * RGBA颜色转换
 */
#define UIColorRGB(r,g,b) UIColorRGBA(r,g,b,1.0f)

// -----------------------------------------


//---------------------- 图片 ----------------------------
#pragma mark -
#pragma mark 图片类

/**
 * 通过文件的路径加载图片数据从而创建并返回图片
 */
#define UIImageWithFileOfType(imageName,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:imageName ofType:ext]]

/**
 * 通过文件的路径加载图片数据从而创建并返回图片
 */
#define UIImageWithFile(imageName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]]

/**
 *返回与指定文件名相关的图片
 */
#define UIImageWithNamed(imageName) [UIImage imageNamed:imageName]

//建议使用前两种宏定义,性能高于后者
// -----------------------------------------



// ---------------- 尺寸 --------------------
#pragma mark -
#pragma mark 尺寸类

/**
 * 获取屏幕宽度
 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

/**
 * 获取屏幕高度
 */
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// -----------------------------------------

//-------------- 系统&设备 ------------------
#pragma mark -
#pragma mark 系统 & 设备

/**
 * 获取系统版本(浮点型小数)
 */
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *获取当前系统语言
 */
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/**
 * 是否是iPad
 */
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/**
 *  判断iPhone5
 */
#define isiPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  判断iPhone6
 */
#define isiPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *  判断iPhone6plus
 */
#define isiPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


#pragma mark -判断是否为真机
/**
 * 判断是否为真机
 */
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#pragma mark -判断是否为模拟器
/**
 * 判断是否为模拟器
 */
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

// -----------------------------------------


// ---------------- 文件路径 --------------------
#pragma mark -
#pragma mark 文件路径

#define TF_DOCUMENTS [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define TF_DOCUMENTS_PATH(x) [TF_DOCUMENTS stringByAppendingPathComponent:x]
#define TF_USER_DOCUMENT_PATH [TF_DOCUMENTS stringByAppendingPathComponent:@"usr"]
#define TF_USER_QRCODE_PATH(x) [TF_USER_DOCUMENT_PATH stringByAppendingPathComponent:x]

#define CACHE_PATH(x) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:x]

// --------------------------------------------


// ---------------- 其他 --------------------
#pragma mark -
#pragma mark 其他

#define weak(weakSelf,self) __weak __typeof(self)weakSelf = self;

#define strong(strongSelf,weakSelf) __strong __typeof(weakSelf)strongSelf = weakSelf;

/**
 * 自动调整文本高度
 */
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define Multline_TextSize(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define Multline_TextSize(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif
// -----------------------------------------

#endif
