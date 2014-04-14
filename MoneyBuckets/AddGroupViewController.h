//
//  AddGroupViewController.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/13/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import <UIKit/UIKit.h>


// Protocol definition starts here
@protocol GroupTableDelegate <NSObject>
@required
- (void) addGroup:(NSString*)groupName withColor:(NSString*)colorName;
@end
// Protocol Definition ends here

@interface AddGroupViewController : UIViewController


@property (nonatomic, weak) id<GroupTableDelegate> delegate;


@end
