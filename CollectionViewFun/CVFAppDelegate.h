//
//  CVFAppDelegate.h
//  CollectionViewFun
//
//  Created by Jonathan on 6/4/13.
//  Copyright (c) 2013 Cocoa Manifest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
