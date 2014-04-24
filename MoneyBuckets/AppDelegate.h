//
//  AppDelegate.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/13/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) NSManagedObjectContext* __managedObjectContext;
@property (nonatomic,strong) NSPersistentStoreCoordinator* __persistentStoreCoordinator;
@property (nonatomic,strong) NSManagedObjectModel* __managedObjectModel;
@property (nonatomic,strong) NSString * hola;

@end
