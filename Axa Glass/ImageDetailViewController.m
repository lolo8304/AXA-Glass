//
//  ImageDetailViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ImageDetailViewController.h"
#import "BSKeyboardControls.h"
#import "InsurenceOptionCell.h"


@interface ImageDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tag;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UIImageView *image;

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
	
	self.tag.text = self.imageModel.keywords;
	self.category.text = self.imageModel.categorizations.lastObject;
	self.price.text = [NSString stringWithFormat:@"%@ %@", self.imageModel.price, self.imageModel.currency];
	
	self.image.image = [UIImage imageNamed:self.imageModel.imageName];
}


- (void) defineFont {
	self.tag.font = [UIFont fontWithName:FONT_BOOK size:12];
	self.category.font = [UIFont fontWithName:FONT_BOOK size:12];
	self.price.font = [UIFont fontWithName:FONT_BOOK size:12];
	
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
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	InsurenceOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InsurenceOptionCell" forIndexPath:indexPath];
	
	if (indexPath.row == 0) {
		cell.desc.text = @"At home";
		cell.logo.image = [UIImage imageNamed:@"option-at-home.png"];
		[cell.informationButton setImage:[UIImage imageNamed:@"info1.png"] forState:UIControlStateNormal];

	}
	else if (indexPath.row == 1) {
		cell.desc.text = @"In the car";
		[cell.informationButton setImage:[UIImage imageNamed:@"info2-get-now.png"] forState:UIControlStateNormal];
		cell.logo.image = [UIImage imageNamed:@"option-in-the-car.png"];

		//info1.png
	}
	else if (indexPath.row == 2) {
		cell.desc.text = @"Outside";
		[cell.informationButton setImage:[UIImage imageNamed:@"info3-viewconditions.png"] forState:UIControlStateNormal];
		cell.logo.image = [UIImage imageNamed:@"option-outside.png"];

	}
	else if (indexPath.row == 3) {
		cell.desc.text = @"Traveling";
		[cell.informationButton setImage:[UIImage imageNamed:@"info3-viewconditions.png"] forState:UIControlStateNormal];
		cell.logo.image = [UIImage imageNamed:@"option-traveling.png"];

	}
	
	return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Return NO if you do not want the specified item to be editable.
	return NO;
}





@end
