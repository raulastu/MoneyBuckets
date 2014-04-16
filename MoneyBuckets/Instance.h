//
//  Instance.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/15/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bucket;

@interface Instance : NSManagedObject

@property (nonatomic, retain) NSNumber * money;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * when;
@property (nonatomic, retain) Bucket *bucket;

@end
