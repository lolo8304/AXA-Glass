//
//  ImageResultTableViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 12/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ImageResultController.h"
#import "ResultImageCell.h"
#import "SimilarImage.h"
#import "ImageDetailViewController.h"


@interface ImageResultController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong) SimilarImage * similarImage;
@end

@implementation ImageResultController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.similarImage = nil;
	
	
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0) return 1;//best match header
	else if (section == 1) return 1; //best match cell
	else if (section == 2) return 1; // header similar
	else {
		return [self.imageModel.similarImages count];
	}
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	ResultImageCell *cell = nil;
	if (indexPath.section == 0) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"BestMatchHeader" forIndexPath:indexPath];
	}
	else if (indexPath.section == 1) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"ResultImageCell" forIndexPath:indexPath];
	}
	else if (indexPath.section == 2) {
		cell = [tableView dequeueReusableCellWithIdentifier:@"SimilarHeader" forIndexPath:indexPath];
	}
	else {
		cell = [tableView dequeueReusableCellWithIdentifier:@"ResultImageCell" forIndexPath:indexPath];
	}
	
	//best match
	if (indexPath.section == 1) {
		cell.photo.image = [UIImage imageNamed:self.imageModel.imageName];
		cell.keyword.text = self.imageModel.keywords;
	}
	else if (indexPath.section==3){
		
		SimilarImage * similarImage = self.imageModel.similarImages[indexPath.row];
		
		cell.photo.image = [UIImage imageNamed:similarImage.imageName];
		
		cell.keyword.text = similarImage.keywords;
		if ( !IsEmpty(similarImage.price) ) {
			cell.price.hidden = NO;
			cell.price.text = [NSString stringWithFormat:@"%@ %@",similarImage.price,similarImage.currency];
		}
		else {
			cell.price.hidden = YES;
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
	if (indexPath.section == 3) {
		self.similarImage = self.imageModel.similarImages[indexPath.row];
	}
	else {
		self.similarImage = nil;
	}
	return indexPath;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	//	if (indexPath.section == 0) {
	//		return 175;
	//	}
	//	else {
	
	if (indexPath.section==0) {
		return 65;
	}
	else if (indexPath.section == 1) return 100;

	else if (indexPath.section==2) {
		return 43;
	}
	else {
		return 100;
	}
	
	
	//}
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
	if ([segue.identifier isEqualToString:@"showInsurenceDetail"]) {
		ImageDetailViewController * destViewController = segue.destinationViewController;
		destViewController.imageModel = self.imageModel ;
		destViewController.similarImage = self.similarImage ;
		
	}
}
@end
