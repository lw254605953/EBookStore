//
//  EBookModel.m
//  EBookStore
//
//  Created by 李巍 on 15/5/12.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "EBookModel.h"

@implementation EBookModel

+ (NSString *)entityName {
    return @"EBook";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"identifier"      :@"id",
             @"title"           :@"title",
             @"coverImage"      :@"img",
             @"currentPage"     :[NSNull null],
             @"maxPageCount"    :[NSNull null],
             @"author"          :@"author",
             @"type"            :@"type"};
}

+ (NSString *)managedObjectEntityName {
    return [[self class] entityName];
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{@"identifier"      :@"identifier",
             @"title"           :@"title",
             @"coverImage"      :@"coverImage",
             @"currentPage"     :@"currentPage",
             @"maxPageCount"    :@"maxPageCount",
             @"author"          :@"author",
             @"type"            :@"type"};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"identifier"];
}

@end
