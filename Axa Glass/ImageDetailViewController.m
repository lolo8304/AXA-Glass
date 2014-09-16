//
//  ImageDetailViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ImageDetailViewController.h"
#import "BSKeyboardControls.h"
#import "ProtectionCell.h"

//Sections
#define kOptionSectionIndex 0
#define kProtectionSectionIndex 1
#define kNumberSection 2

//Number
#define kNumberOption 1
#define kNumberProtection 4


//Mode
#define kStatusCheck @"option-check.png"
#define kStatusKO @"option-croix.png"
#define kStatusWarning @"option-exclamation.png"

#define kImacIndex 3
#define kVuittonIndex 1

@interface ImageDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tag;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) MBProgressHUD * hud;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) BSKeyboardControls * keyboardControls;

@end

@implementation ImageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	[self defineFont];
	
	//Init fields
	NSArray *fields = @[ self.tag, self.price ];
	
	[self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
	[self.keyboardControls setDelegate:self];
	
	for (UITextField * textField in fields) {
		textField.delegate = self;
	}
	
	self.keyboardControls.previousTitle = NSLocalizedString(@"Previous", @"Previous");
	self.keyboardControls.nextTitle = NSLocalizedString(@"Next",@"Next");
	self.keyboardControls.doneTitle = NSLocalizedString(@"End", @"End");
	
	self.category.text = self.imageModel.categorizations.lastObject;
	
	if( self.similarImage ==nil) {
		self.tag.text = self.imageModel.keywords;
		self.price.text = [NSString stringWithFormat:@"%@", self.imageModel.price];
	}
	else {
		self.tag.text = self.similarImage.keywords;
		self.price.text = [NSString stringWithFormat:@"%@", self.similarImage.price];
	}
	
	self.image.image = [UIImage imageNamed:self.imageModel.imageName];
}


- (void) defineFont {
	self.tag.font = [UIFont fontWithName:FONT_BOOK size:14];
	self.category.font = [UIFont fontWithName:FONT_BOOK size:14];
	self.price.font = [UIFont fontWithName:FONT_BOOK size:14];
	
	self.yourProtectionTitle.font = [UIFont fontWithName:FONT_DEMI size:24];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self.keyboardControls setActiveField:textField];
}

#pragma mark -
#pragma mark Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
	[self.keyboardControls setActiveField:textView];
}

#pragma mark -
#pragma mark Keyboard Controls Delegate

//- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction {
//}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls {
	[self.view endEditing:YES];
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



#pragma mark - Tableview


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return kNumberSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	if (section == kOptionSectionIndex) return kNumberOption;
	else if (section == kProtectionSectionIndex) return kNumberProtection;
	else return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LoggerData(1, @"row=%ld section = %ld", (long)indexPath.row, (long)indexPath.section);

	if (indexPath.section==kOptionSectionIndex) {

		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionsCell" forIndexPath:indexPath];

		return cell;
	
	}
	else if (indexPath.section==kProtectionSectionIndex) {
		ProtectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProtectionCell" forIndexPath:indexPath];
		

		if (indexPath.row == 0) {
			cell.desc.text = @"At home";
			cell.logo.image = [UIImage imageNamed:@"option-at-home.png"];
			[cell.informationButton setImage:[UIImage imageNamed:@"option-info.png"] forState:UIControlStateNormal];
			cell.status.image =[UIImage imageNamed:kStatusCheck];
			
			if ([ImagesModel sharedManager].currentImageIndex == kImacIndex) {
				cell.status.image =[UIImage imageNamed:kStatusCheck];
			}
			else if ([ImagesModel sharedManager].currentImageIndex == kVuittonIndex) {
				cell.status.image =[UIImage imageNamed:kStatusCheck];
			}
		}
		else if (indexPath.row == 1) {
			cell.desc.text = @"In the car";
			[cell.informationButton setImage:[UIImage imageNamed:@"option-info.png"] forState:UIControlStateNormal];
			cell.logo.image = [UIImage imageNamed:@"option-in-the-car.png"];
			cell.status.image =[UIImage imageNamed:kStatusKO];
			
			//option-info.png
			if ([ImagesModel sharedManager].currentImageIndex == kImacIndex) {
				cell.status.image =[UIImage imageNamed:kStatusWarning];
			}
			else if ([ImagesModel sharedManager].currentImageIndex == kVuittonIndex) {
				cell.status.image =[UIImage imageNamed:kStatusKO];
			}
			
		}
		else if (indexPath.row == 2) {
			cell.desc.text = @"Outside";
			[cell.informationButton setImage:[UIImage imageNamed:@"option-info.png"] forState:UIControlStateNormal];
			cell.logo.image = [UIImage imageNamed:@"option-outside.png"];
			cell.status.image =[UIImage imageNamed:kStatusWarning];
			if ([ImagesModel sharedManager].currentImageIndex == kImacIndex) {
				cell.status.image =[UIImage imageNamed:kStatusKO];
			}
			else if ([ImagesModel sharedManager].currentImageIndex == kVuittonIndex) {
				cell.status.image =[UIImage imageNamed:kStatusKO];
			}
			
		}
		else if (indexPath.row == 3) {
			cell.desc.text = @"Traveling";
			[cell.informationButton setImage:[UIImage imageNamed:@"option-info.png"] forState:UIControlStateNormal];
			cell.logo.image = [UIImage imageNamed:@"option-traveling.png"];
			cell.status.image =[UIImage imageNamed:kStatusWarning];
			
			if ([ImagesModel sharedManager].currentImageIndex == kImacIndex) {
				cell.status.image =[UIImage imageNamed:kStatusKO];
			}
			else if ([ImagesModel sharedManager].currentImageIndex == kVuittonIndex) {
				cell.status.image =[UIImage imageNamed:kStatusWarning];
			}
			
		}
		return cell;
	}
	
	LoggerError(0, @"Your assurance detail : Cell return nil row=%ld section = %ld", (long)indexPath.row, (long)indexPath.section);

	return nil;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
//	UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
//	if ([cell.reuseIdentifier isEqualToString: @"PayFooter" ]) {
//	//if ( indexPath.section == (kProtectionSectionIndex) && indexPath.row == (kNumberProtection-1)) {
//		return indexPath;
//	}
	return nil;
}



//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	
//	[self loader];
//}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	NSString * cellIdentifier = nil;
	
	cellIdentifier = @"TitleHeader";
	
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	UILabel *title = (UILabel *)[cell viewWithTag:1];
	
	if (section == 0 ) {
		title.text = @"YOUR OPTIONS";
	}
	else {
		title.text = @"YOUR PROTECTIONS";
	}
	[title sizeToFit];
	
	//title.font = [UIFont fontWithName:FONT_DEMI size:17.0f];
	if (cell == nil){
		[NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
	}
	return cell;
	
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	NSString * cellIdentifier = nil;
	//	else
	if (section == [self.tableView numberOfSections]-1) {
		cellIdentifier = @"PayFooter";
		
		UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		UILabel *title = (UILabel *)[cell viewWithTag:1];
		title.font = [UIFont fontWithName:FONT_DEMI size:18.0f];
		if (cell == nil){
			[NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
		}
		return cell;
		
	}
	return nil;
}



#pragma mark - cell size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) return 60;
	else {
		return 70;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	
	if (section==[self.tableView numberOfSections]-1) {
		return 60;
	}
	return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	//if (section==0) return 0;
	return 24;
}

- (IBAction)payButton:(id)sender {
	[self loader];
}




#pragma mark loader

- (void) loader {
	MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	self.hud = hud;
	hud.mode = MBProgressHUDModeCustomView;
	
	hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check.png"]];
	int duration = 2;
	
	[hud hide:YES afterDelay:duration];
	[hud setCompletionBlock:^{
		[self.navigationController popToRootViewControllerAnimated:YES];
	}];
	
}

- (IBAction)done:(id)sender {
	[self loader];
}

- (IBAction)cancel:(id)sender {
	[self dismissViewControllerAnimated:YES completion:Nil];
}


@end
