//
//  AddGroupViewController.m
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/13/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import "AddGroupViewController.h"

@interface AddGroupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;

@property (weak, nonatomic) IBOutlet UITextField *colorField;

@end

@implementation AddGroupViewController


@synthesize delegate = _delegate;


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
- (IBAction)Cancel:(id)sender {
    self.name.text=@"";
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)SaveGroup:(id)sender {
    
//  Input Validation
//    Uniquenes Validation
    NSString *groupName = self.name.text;
    NSString *colorName = self.colorField.text;
    [self.delegate addGroup: groupName withColor:colorName];
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
