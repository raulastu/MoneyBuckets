//
//  InstanceTableViewController.m
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/24/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import "InstanceTableViewController.h"

@interface InstanceTableViewController ()

@end

@implementation InstanceTableViewController


@synthesize managedObjectContext;
@synthesize bucket;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.navigationItem setTitle: [bucket name]];
    [self refreshViewsFromData ];
//    self.navigationItem setBackBarButtonItem:<#(UIBarButtonItem *)#>
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)refreshViewsFromData{
    double total= 0;
    for (Instance * ins in [bucket instances]) {
        total +=[[ins money] doubleValue];
    }
    NSString * title = [NSString stringWithFormat:@"%@ %.2f",[bucket name], total];
    [self.navigationItem setTitle:title];
}
-(void) addInstance: (NSString *) instanceName withDate:(NSDate *) date withMoneyAmount:(NSNumber *) money {
    Instance *instance = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Instance"
                      inManagedObjectContext:managedObjectContext];
    
    instance.name=instanceName;
    instance.when=date;
    instance.money=money;
    
    [bucket addInstancesObject:instance];
    
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self refreshViewsFromData];
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.bucket instances] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"instanceCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"instanceCell"];
    }
    UILabel * nameLabel = (UILabel *) [cell viewWithTag:100];
    UILabel * dateLabel = (UILabel *) [cell viewWithTag:101];
    UILabel * moneyLabel = (UILabel *) [cell viewWithTag:102];
    
    // Configure the cell...
    //    NSArray * ar = [NSArray arrayWithArray: ];
    NSMutableArray * descs = [[NSMutableArray alloc]init];
    [descs addObject:@"name"];
    NSArray * ar = [[self.bucket instances] allObjects];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    //Optionally for time zone converstions
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:[[ar objectAtIndex:indexPath.row] when]];
    
    
    
    nameLabel.text=[[ar objectAtIndex:indexPath.row] name];
    dateLabel.text=stringFromDate;
    moneyLabel.text = [[[ar objectAtIndex:indexPath.row] money] stringValue];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Instance * selectedInstance = [[[bucket instances] allObjects] objectAtIndex:indexPath.row];
        [bucket removeInstancesObject:selectedInstance];
        NSError *error;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self refreshViewsFromData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"AddInstanceSegue"])
    {
        // Get reference to the destination view controller
        AddInstanceViewController *vc = [segue destinationViewController];
        vc.delegate=self;
    }else if([[segue identifier] isEqualToString:@"BucketInstancesSegue"]){
        InstanceTableViewController *vc = [segue destinationViewController];
        vc.managedObjectContext = [self managedObjectContext];
//        vc.bucket = selectedBucket;
        //        NSLog(@"%@", selectedGroup);
        //        vc.delegate=self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
