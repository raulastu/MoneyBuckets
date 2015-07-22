//
//  AppDelegate.m
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/13/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import "AppDelegate.h"
#import "GroupTableViewController.h"

#import "Group.h"

#import "Bucket.h"

//#import "Foundation.framework.h"

//#import "NSFileManager.h"


@implementation AppDelegate


@synthesize window = _window;

@synthesize __managedObjectContext;
@synthesize __persistentStoreCoordinator;
@synthesize __managedObjectModel;
//@synthesize hola;


- (NSString*) hola{
    if(_hola==nil)
        return _hola;
    else return @"";
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    id currentiCloudToken = [[NSFileManager defaultManager] ubiquityIdentityToken];
    
    if (currentiCloudToken) {
        NSData *newTokenData =
        [NSKeyedArchiver archivedDataWithRootObject: currentiCloudToken];
        [[NSUserDefaults standardUserDefaults]
         setObject: newTokenData
         forKey: @"com.apple.MoneyBuckets.UbiquityIdentityToken"];
    } else {
        [[NSUserDefaults standardUserDefaults]
         removeObjectForKey: @"com.apple.MoneyBuckets.UbiquityIdentityToken"];
    }
  
    [[NSNotificationCenter defaultCenter]
     addObserver: self
     selector: @selector (iCloudAccountAvailabilityChanged:)
     name: NSUbiquityIdentityDidChangeNotification
     object: nil];
    
    NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    NSString * firstLaunchWithiCloudAvailable = [userDef objectForKey:@"com.huahlabs.MoneyBuckets.firstLaunchWithiCloudAvailable"];
    
    
    if (currentiCloudToken && ![firstLaunchWithiCloudAvailable isEqualToString:@"YES"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Choose Storage Option"
                              message: @"Should documents be stored in iCloud and available on all your devices?"
                              delegate: self
                              cancelButtonTitle: @"Local Only"
                              otherButtonTitles: @"Use iCloud",
                               nil];
        [alert show];
    }
    
    

    NSURL *url = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    
    
    NSLog(@"%@", currentiCloudToken);
    
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error;
//    if (![context save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Group"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Group *info in fetchedObjects) {
        NSLog(@"Name: %@", info.name);
        NSLog(@"Zip: %@", info.colorCode);
    }
//    NSLog(_hola);
    
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    GroupTableViewController *controller = (GroupTableViewController *)navigationController.topViewController;
    controller.managedObjectContext = self.managedObjectContext;
    
    
    return YES;
}

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger) buttonIndex{
    if(buttonIndex==1){
        NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
        [userDef setObject:@"YES" forKey:@"com.huahlabs.MoneyBuckets.firstLaunchWithiCloudAvailable"];
        [userDef synchronize];
    }
}

//#pragma core data stuff
//
//- (void)setupManagedObjectContext
//{
//    self.managedObjectContext =
//    [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    self.managedObjectContext.persistentStoreCoordinator =
//    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: self.managedObjectModel];
//    NSError* error;
//    [self.managedObjectContext.persistentStoreCoordinator
//     addPersistentStoreWithType:NSSQLiteStoreType
//     configuration:nil
//     URL:self.storeURL
//     options:nil
//     error:&error];
//    if (error) {
//        NSLog(@"error: %@", error);
//    }
//    self.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
//}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AppModel" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MoneyBuckets.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
