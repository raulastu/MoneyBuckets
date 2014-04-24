//
//  AddBucketViewController.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/17/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

// Protocol definition starts here
@protocol BucketTableDelegate <NSObject>
@required
- (void) addBucket:(NSString*)bucketName;
@end
// Protocol Definition ends here

@interface AddBucketViewController : UIViewController

@property (nonatomic, weak) id<BucketTableDelegate> delegate;

@end
