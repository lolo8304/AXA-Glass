//
//  ChooserViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ChooserViewController.h"
#import "ImageResultController.h"

@interface ChooserViewController ()
@property (weak, nonatomic) IBOutlet UIButton *image1;
@property (strong, nonatomic) MBProgressHUD * hud;

@end

@implementation ChooserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
	//self.navigationItem.titleView = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}


- (IBAction)selectImage:(id)sender {
	
	
	MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	self.hud = hud;
	hud.animationType = MBProgressHUDAnimationFade;
	//self.hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
	hud.dimBackground=YES;
	//hud.minShowTime = 2;
	//hud.graceTime=0.1;
	
	hud.mode = MBProgressHUDModeAnnularDeterminate;
	hud.labelText = @"Analyzing image";
	//hud.detailsLabelText = @"Processing";
	//[hud showWhileExecuting:@selector(doSomeFunkyStuff) onTarget:self withObject:nil animated:YES];
	
	
	[hud showAnimated:YES whileExecutingBlock:^{
		[self simulateLoader];
	// hud.progress = 1.0f;
	} completionBlock:^{
		if (self.isViewLoaded && self.view.window && self.parentViewController != nil) {
			[self performSegueWithIdentifier:@"showImageMatch" sender:sender];}
	}];

}

- (void)simulateLoader {
	float progress = 0.0;
	
	while (progress < 1.0) {
		progress += 0.02;
		self.hud.progress = progress;
		if (FAST_MODE) {
			usleep(10000);
		}
		else {
			usleep(50000);
		}
	}
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showImageMatch"]) {
		ImageResultController * destViewController = segue.destinationViewController;
		
		
		[ImagesModel sharedManager].currentImageIndex = ((UIButton *)sender).tag;
		
		ImageModel * imageModel = [ImagesModel sharedManager].imageModelAtCurrentIndex;
		
		LoggerData(1, @"Similar images count %lu", (unsigned long)[imageModel.similarImages count]);
		destViewController.imageModel = imageModel ;
		
	}
}
- (IBAction)takeAPhoto:(id)sender {
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Picture", @"eMail receipt", @"Scan barcode", @"Scan paper receipt", nil];
	
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault; [actionSheet showInView:self.view];
	
}




@end
