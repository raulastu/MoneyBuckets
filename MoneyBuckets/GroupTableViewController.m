//
//  GroupTableViewController.m
//  MoneyBuckets
//
//  Created by Raul Ramirez on 4/13/14.
//  Copyright (c) 2014 huahlabs. All rights reserved.
//

#import "GroupTableViewController.h"
#import "BucketTableViewController.h"
#import "Group.h"

@interface GroupTableViewController ()

@end


@implementation GroupTableViewController

@synthesize managedObjectContext;
@synthesize groupInfos;

Group * selectedGroup;

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
    
    [self reloadGroupList];
//    self 
//    NSLog(self.groupInfos);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadGroupList {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Group" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.groupInfos = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
}



#pragma mark - AddGroup Modal

- (void)addGroup:(NSString*)groupName withColor:(NSString*)colorCode
{
    
    Group *group = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"Group"
                                            inManagedObjectContext:managedObjectContext];

//    [group setValue:groupName forKeyPath:@"name"];
//    [group setValue:colorCode forKeyPath:@"colorCode"];
    group.name = groupName;
    group.colorCode = colorCode;
    group.buckets = [group.buckets init];
//    [group addBuckets: [[NSOrderedSet init]alloc]];
//    [group setValue:NS forKeyPath:@"buckets"];
    
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    NSLog(@"%@ %@ %@", @"GroupTableViewController.addGroup", groupName, colorCode);
//    [self refreshControl];
    [self reloadGroupList];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groupInfos count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"groupCell"];
    }
    
    // Configure the cell...
    cell.textLabel.text=[[self.groupInfos objectAtIndex:indexPath.row] name];
    cell.detailTextLabel.text=[[self.groupInfos objectAtIndex:indexPath.row] colorCode];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"%l", indexPath.row);
    NSLog(@"xl");
}

//- (void)table
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
    selectedGroup = [groupInfos objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"GroupBucketsSegue" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"AddGroupSegue"])
    {
        // Get reference to the destination view controller
        AddGroupViewController *vc = [segue destinationViewController];
        vc.delegate=self;
    }else if([[segue identifier] isEqualToString:@"GroupBucketsSegue"]){
        BucketTableViewController *vc = [segue destinationViewController];
        vc.managedObjectContext = [self managedObjectContext];
        vc.group = selectedGroup;
        NSLog(@"%@", selectedGroup);
        //        vc.delegate=self;
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//-(NSString *)tableView:(UITableView *)tableView titleForSwipeAccessoryButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//        return @"Delete";
//}

-(void)tableView:(UITableView *)tableView swipeAccessoryButtonPushedForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Group * group = [groupInfos objectAtIndex:indexPath.row];
        [managedObjectContext deleteObject:group];
        NSError *error;
        if (![managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        [self reloadGroupList];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
