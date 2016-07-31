//
//  StudentTableViewController.m
//  CoreDataProgramming
//
//  Created by Rajesh on 19/12/15.
//  Copyright © 2015 CDAC. All rights reserved.
//

#import "StudentTableViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@implementation StudentTableViewController

@synthesize arrayStudent;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setEditing:true];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //find object to delete
        NSManagedObject *obj = [arrayStudent objectAtIndex:indexPath.row];
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *objContext = [appDelegate managedObjectContext];
        [objContext deleteObject:obj];
        
        //save context
        NSError *error;
        BOOL result = [objContext save:&error];
        
        if (error == nil) {
            //remove row from tableView
            
            [arrayStudent removeObjectAtIndex:indexPath.row];
            
            NSArray *arrayIndexPath = [[NSArray alloc]initWithObjects:indexPath, nil];
            [self.tableView deleteRowsAtIndexPaths:arrayIndexPath withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    //load all save object from context
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *objContext = [appDelegate managedObjectContext];
    
    //prepare selection query request to fetch Student objects
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Sudent"];
    
    //execute fetch request
    NSError *error;
    NSArray *array = [objContext executeFetchRequest:request error:&error];
    
    arrayStudent = [[NSMutableArray alloc]initWithArray:array];
    
    if (error == nil) {
        [self.tableView reloadData];
    }
    else
    {
        NSLog(@"error:%@",error);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return arrayStudent.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    NSManagedObject *obj = [arrayStudent objectAtIndex:indexPath.row];
    
    NSString *name = [obj valueForKey:@"name"];
    NSNumber *numRollno = [obj valueForKey:@"rollno"];
    
    NSNumber *numiOS = [obj valueForKey:@"ios_marks"];
    NSNumber *numandroid = [obj valueForKey:@"android_marks"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d,%@",[numRollno intValue],name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"marks android:%f, ios:%f",[numiOS floatValue],[numandroid floatValue]];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
