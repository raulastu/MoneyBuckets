//
//  Bucket.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/15/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Group, Instance;

@interface Bucket : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Group *group;
@property (nonatomic, retain) NSSet *instances;
@end

@interface Bucket (CoreDataGeneratedAccessors)

- (void)addInstancesObject:(Instance *)value;
- (void)removeInstancesObject:(Instance *)value;
- (void)addInstances:(NSSet *)values;
- (void)removeInstances:(NSSet *)values;

@end
