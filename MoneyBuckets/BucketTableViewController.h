//
//  TableViewController.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/17/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "AddBucketViewController.h"

@interface BucketTableViewController : UITableViewController <BucketTableDelegate>


@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, strong) Group* group;

@end
