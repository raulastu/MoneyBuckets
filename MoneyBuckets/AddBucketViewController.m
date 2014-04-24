//
//  AddBucketViewController.m
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/17/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import "AddBucketViewController.h"

@interface AddBucketViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtBucketName;

@end

@implementation AddBucketViewController


@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)saveBucket:(id)sender {
    NSString * bucketName = self.txtBucketName.text;
    [self.delegate addBucket:bucketName];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
