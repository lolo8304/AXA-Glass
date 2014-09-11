//
//  ImageDetailViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ImageDetailViewController.h"
#import "ImagesModel.h"


@interface ImageDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tag;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation ImageDetailViewController

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
	
	//Init fields
	NSArray *fields = @[ self.tag, self.price];
	
	//[self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
	//[self.keyboardControls setDelegate:self];
	
	
	
	[[ImagesModel sharedManager] fakeData];
	
	LoggerData(1, @"Data count %lu", (unsigned long)[[ImagesModel sharedManager].images count]);
	
	ImageModel * imageModel = [ImagesModel sharedManager].imageModelAtCurrentIndex;
	self.tag.text = imageModel.keywords;
	self.category.text = imageModel.categorizations.lastObject;
	self.price.text = [NSString stringWithFormat:@"%@ %@", imageModel.price, imageModel.currency];
	
	self.image.image = [UIImage imageNamed:imageModel.imageName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
