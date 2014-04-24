//
//  AddInstanceViewController.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/24/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
// Protocol definition starts here
@protocol InstanceTableDelegate <NSObject>
@required

-(void) addInstance: (NSString *) instanceName withDate:(NSDate *) date withMoneyAmount:(NSNumber *) money;
@end
// Protocol Definition ends here


@interface AddInstanceViewController : UIViewController

@property (nonatomic, weak) id<InstanceTableDelegate> delegate;

@end
