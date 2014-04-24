//
//  Group.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/23/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bucket;

@interface Group : NSManagedObject

@property (nonatomic, retain) NSString * colorCode;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *buckets;
@end

@interface Group (CoreDataGeneratedAccessors)

- (void)addBucketsObject:(Bucket *)value;
- (void)removeBucketsObject:(Bucket *)value;
- (void)addBuckets:(NSSet *)values;
- (void)removeBuckets:(NSSet *)values;

@end
