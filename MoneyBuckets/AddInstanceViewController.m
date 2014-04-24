//
//  AddInstanceViewController.m
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/24/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import "AddInstanceViewController.h"

@interface AddInstanceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtInstanceName;
@property (weak, nonatomic) IBOutlet UITextField *txtMoney;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerMoney;

@end


@implementation AddInstanceViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saveInstance:(id)sender {
    NSString * instanceName = self.txtInstanceName.text;
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * money = [f numberFromString:self.txtMoney.text];
    
    NSDate * when = self.datePickerMoney.date;
    [self.delegate addInstance:instanceName withDate:when withMoneyAmount:money];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
