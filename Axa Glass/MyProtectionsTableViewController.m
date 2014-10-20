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

    ProtectionGroupModel *group = self.currentModel.groups[indexPath.section];
    MyProtectionCell *cell = nil;
    
    if (indexPath.row == 0) {
        /* if group */
        cell = [tableView dequeueReusableCellWithIdentifier: @"ItemCell-group" forIndexPath:indexPath];
        cell.title.text = group.title;
        NSString *logoNamed = [ NSString stringWithFormat:@"option-%@.png", group.identifier ];
        cell.image.image = [UIImage imageNamed: logoNamed];
        
    } else {
        NSInteger curItem = indexPath.row - 1;
        ProtectionItemModel *item = group.items[curItem];
        NSString *cellIdentifier = [ NSString stringWithFormat:@"ItemCell-%@", item.type ];
        cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier forIndexPath:indexPath];
        
        NSString *coveredImageNamed = [ NSString stringWithFormat:@"option-%@.png", item.covered ];
        cell.coveredImage.image = [UIImage imageNamed: coveredImageNamed];
        NSString *title =[ NSString stringWithFormat:@"%@", item.title ];
        cell.title.text = title;
        
        /* if type == "coverage" */
        if ([@"coverage" isEqualToString:item.type]) {
            cell.premium.text = [ NSString stringWithFormat:@"%@.-", item.premium ];
            cell.insuredSum.text = [ NSString stringWithFormat:@"%@.-", item.insuredSum ];
            cell.deductible.text = [ NSString stringWithFormat:@"%@.-", item.deductible ];
            
        /* if type == "object-capture" */
        } else if ([@"object-capture" isEqualToString:item.type]) {
            cell.price.text = [ NSString stringWithFormat:@"%@", item.price ];
            cell.category.text = [ NSString stringWithFormat:@"%@", item.category ];
            cell.image.image = [UIImage imageNamed: item.image];
        }
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
    
    LoggerData(1, @"indexPath.section=%d", indexPath.section);
    LoggerData(1, @"indexPath.row=%d", indexPath.row);

    ProtectionGroupModel *group = self.currentModel.groups[indexPath.section];
    self.selectedGroup = group;
    if (indexPath.row == 0) {
        self.selectedItem = nil;
        return nil;
    } else {
        NSInteger curItem = indexPath.row - 1;
        ProtectionItemModel *item = group.items[curItem];
        self.selectedItem = item;
    }
    return indexPath;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 42;
    }
    else {
        return 80;
    }
}

 
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
        MyProtectionDetailsViewController * destViewController = segue.destinationViewController;
        
    }
}


- (IBAction)cancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
