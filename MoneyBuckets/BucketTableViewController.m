//
//  BucketTableViewControlle.h
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/17/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import "BucketTableViewController.h"
#import "Bucket.h"
#import "Group.h"
#import "InstanceTableViewController.h"

@interface BucketTableViewController ()

@end

@implementation BucketTableViewController


@synthesize managedObjectContext;
@synthesize group;

Bucket * selectedBucket;

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
    
    [self.navigationItem setTitle: [group name]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSLog(@"loaded Group %@",group);
    NSLog(@"loaded Group Buckets %zd",[[self.group buckets] count]);
    for (Bucket *bu in [self.group buckets]) {
        NSLog(@"%@",bu.name);
    }
//    [self addDummyBucket];
}

//-(void) reloadBucketList {
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription
//                                   entityForName:@"Bucket" inManagedObjectContext:managedObjectContext];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    self.group.buckets = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
//}

-(void) addDummyBucket{
    Bucket *bucket = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Bucket"
                              inManagedObjectContext:managedObjectContext];
    
//    [bucket setValue:@"xxxxzzs" forKeyPath:@"name"];
    bucket.name = @"xxasdxx";
    [group addBucketsObject:bucket];
//    
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
}

-(void) addBucket: (NSString *) bucketName {
    Bucket *bucket = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Bucket"
                      inManagedObjectContext:managedObjectContext];
    
    [bucket setValue:bucketName forKeyPath:@"name"];
    
    [group addBucketsObject:bucket];
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
//    [self reloadGroupList];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[group buckets] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bucketCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"bucketCell"];
    }
    
    // Configure the cell...
//    NSArray * ar = [NSArray arrayWithArray: ];
    NSMutableArray * descs = [[NSMutableArray alloc]init];
    [descs addObject:@"name"];
    NSArray * ar = [[self.group buckets] allObjects];
    
    cell.textLabel.text=[[ar objectAtIndex:indexPath.row] name];
    
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
        Bucket * selectedBucket = [[[group buckets] allObjects] objectAtIndex:indexPath.row];
        [group removeBucketsObject:selectedBucket];
        NSError *error;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    selectedBucket = [[[group buckets] allObjects] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"BucketInstancesSegue" sender:self];
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
    if ([[segue identifier] isEqualToString:@"AddBucketSegue"])
    {
        // Get reference to the destination view controller
        AddBucketViewController *vc = [segue destinationViewController];
        vc.delegate=self;
    }else if([[segue identifier] isEqualToString:@"BucketInstancesSegue"]){
        InstanceTableViewController *vc = [segue destinationViewController];
        vc.managedObjectContext = [self managedObjectContext];
        vc.bucket = selectedBucket;
//        NSLog(@"%@", selectedGroup);
        //        vc.delegate=self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
