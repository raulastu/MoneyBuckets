//
//  Group.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/15/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Group : NSManagedObject

@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *buckets;
@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addBucketsObject:(NSManagedObject *)value;
- (void)removeBucketsObject:(NSManagedObject *)value;
- (void)addBuckets:(NSSet *)values;
- (void)removeBuckets:(NSSet *)values;

@end
