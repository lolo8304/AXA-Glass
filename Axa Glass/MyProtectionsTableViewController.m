//
//  MyProtectionsTableViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 12/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "MyProtectionsTableViewController.h"
#import "MyProtectionDetailsViewController.h"
#import "MyProtectionCell.h"
#import "ProtectionsModel.h"
#import "ProtectionModel.h"
#import "ProtectionGroupModel.h"
#import "ProtectionItemModel.h"


@interface MyProtectionsTableViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong) ProtectionItemModel * selectedItem;
@property (strong) ProtectionGroupModel * selectedGroup;
@end

@implementation MyProtectionsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedItem = nil;
    self.selectedGroup = nil;
    self.models = [ProtectionsModel sharedManager];
    self.currentModel = self.models.items[0] ;
    
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.currentModel.groups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    ProtectionGroupModel *group =self.currentModel.groups[section];
    return [group.items count]+1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyProtectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    ProtectionGroupModel *group = self.currentModel.groups[indexPath.section];
    //header
    if (indexPath.row == 0) {
        cell.title.text = group.title;
//        cell.details.hidden = YES;
        cell.type.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    } else {
        NSInteger curItem = indexPath.row - 1;
        ProtectionItemModel *item = group.items[curItem];
        cell.title.text = item.title;
        /*
        if ( !IsEmpty(item.premium) ) {
            cell.details.text = [ NSString stringWithFormat:@"%@", item.premium ];
        } else if (!IsEmpty(item.price) ) {
            cell.details.text = [ NSString stringWithFormat:@"%@", item.price ];
        } else {
            cell.details.hidden = NO;
        }
         */
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}




- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProtectionGroupModel *group = self.currentModel.groups[indexPath.section];
    ProtectionItemModel *item = group.items[indexPath.row];
    self.selectedGroup = group;
    self.selectedItem = item;
    return indexPath;
}


/*

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //	if (indexPath.section == 0) {
    //		return 175;
    //	}
    //	else {
    
    if (indexPath.section==0) {
        return 65;
    }
    else if (indexPath.section == 1 || indexPath.section==3) {
        return 85;
    }
    else if (indexPath.section==2) {
        return 43;
    }
    else {
        return 0;
    }
    
    //}
}
*/
 
 
#pragma mark - header

//-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//	NSString * cellIdentifier = nil;
//	if (section==0) {
//		cellIdentifier = @"BestMatchHeader";
//	}
//	else if (section == 1) {
//		cellIdentifier = @"SimilarHeader";
//	}
//
//	if (cellIdentifier) {
//		UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//		UILabel *title = (UILabel *)[cell viewWithTag:1];
//		title.font = [UIFont fontWithName:FONT_DEMI size:25.0f];
//		if (cell == nil){
//			[NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
//		}
//		return cell;
//
//	}
//	return nil;
//}


//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//	if (section==0) {
//		return 65;
//	}
//	else if (section==1) {
//		return 43;
//	}
//	return 0;
//
//}

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showProtectionDetail"]) {
//        MyProtectionDetailsViewController * destViewController = segue.destinationViewController;
        
    }
}


- (IBAction)cancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
