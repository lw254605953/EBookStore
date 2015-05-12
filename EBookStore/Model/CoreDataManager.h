//
//  CoreDataManager.h
//  JinyongAllInOne
//
//  Created by 李巍 on 15/5/12.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EBook;

@interface CoreDataManager : NSObject

+ (instancetype)sharedInstance;
- (EBook *)insertEBookWithIdentifier:(NSDictionary *)bookInfo;
- (void)updateEBookWithModel:(EBook *)eBook;
- (EBook *)fetchEBookWithBookIdentifier:(NSString *)identifier;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
