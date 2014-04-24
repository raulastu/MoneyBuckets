//
//  InstanceTableViewController.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/24/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bucket.h"
#import "Instance.h"
#import "AddInstanceViewController.h"

@interface InstanceTableViewController : UITableViewController <InstanceTableDelegate>

@property (strong, nonatomic) Bucket * bucket;
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;


@end
