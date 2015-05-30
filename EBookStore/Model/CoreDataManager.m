//
//  CoreDataManager.m
//  JinyongAllInOne
//
//  Created by 李巍 on 15/5/12.
//  Copyright (c) 2015年 李巍. All rights reserved.
//

#import "CoreDataManager.h"
#import "EBookModel.h"

@implementation CoreDataManager

+ (instancetype)sharedInstance {
	static dispatch_once_t pred = 0;
	__strong static id _sharedObject = nil;
	dispatch_once(&pred, ^{
		_sharedObject = [[self alloc] init];
	});
	return _sharedObject;
}

#pragma mark -

- (BOOL)insertModelWithJSON:(NSDictionary *)json {
    NSError *error = nil;
    EBookModel *model = [MTLJSONAdapter modelOfClass:[EBookModel class] fromJSONDictionary:json error:&error];
    if (error) {
        NSLog(@"转换对象错误：%@", [error localizedDescription]);
        return NO;
    }
    return [self insertModel:model];
}

- (BOOL)insertModel:(EBookModel *)model {
    NSError *error = nil;
    [MTLManagedObjectAdapter managedObjectFromModel:model insertingIntoContext:self.managedObjectContext error:&error];
    if (error) {
        NSLog(@"insertModelByCoreData 插入新对象错误：%@", [error localizedDescription]);
        return NO;
    }
    [self saveContext];
    return YES;
}

- (BOOL)updateModel:(EBookModel *)model {
    return [self insertModel:model];
}

- (EBookModel *)fetchEBookWithBookIdentifier:(NSString *)identifier {
	NSError *error = nil;
	NSString *entityName = [[EBookModel class] entityName];
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchBatchSize:10];
	fetchRequest.returnsObjectsAsFaults = NO;
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", identifier];
	[fetchRequest setPredicate:predicate];
	NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
	if (fetchedObjects == nil) {
		NSLog(@"没有查到相应的条件");
		return nil;
	}
	if (error) {
		NSLog(@"查询书籍错误 %@",error);
		return nil;
	}
    EBookModel *model = [MTLManagedObjectAdapter modelOfClass:[EBookModel class] fromManagedObject:[fetchedObjects lastObject] error:&error];
    if (error) {
        NSLog(@"查询结果转模型错误 %@", error);
        return nil;
    }
	return model;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
	// The directory the application uses to store the Core Data store file. This code uses a directory named "LW.JinyongAllInOne" in the application's documents directory.
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
	// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
	if (_managedObjectModel != nil) {
		return _managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"EBookStore" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	// The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
	if (_persistentStoreCoordinator != nil) {
		return _persistentStoreCoordinator;
	}
	
	// Create the coordinator and store
	
	_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"EBookStore.sqlite"];
	NSError *error = nil;
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@(YES), NSMigratePersistentStoresAutomaticallyOption, @(YES), NSInferMappingModelAutomaticallyOption, nil];
	NSString *failureReason = @"There was an error creating or loading the application's saved data.";
	if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
		// Report any error we got.
		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
		dict[NSLocalizedFailureReasonErrorKey] = failureReason;
		dict[NSUnderlyingErrorKey] = error;
		error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
		// Replace this with code to handle the error appropriately.
		// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
	
	return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
	// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
	if (_managedObjectContext != nil) {
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (!coordinator) {
		return nil;
	}
	_managedObjectContext = [[NSManagedObjectContext alloc] init];
	[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
	if (managedObjectContext != nil) {
		NSError *error = nil;
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Replace this implementation with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
}

@end
