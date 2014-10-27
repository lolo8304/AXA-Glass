//
//  ChooserViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ChooserViewController.h"
#import "ImageResultController.h"
#import "AHReach.h"
#import "ImageDetection.h"

@interface ChooserViewController ()
@property (weak, nonatomic) IBOutlet UIButton *image1;
@property (strong, nonatomic) MBProgressHUD * hud;
@property (nonatomic, assign) BOOL reachableInternet;
@property (strong, nonatomic) AHReach *defaultInventory42;


@end

@implementation ChooserViewController

static NSArray *_CAPTURED_ACTIONS;

+ (void)initialize {
    _CAPTURED_ACTIONS = @[
      @"Picture",    @"Read eMail receipt", @"Scan barcode", @"Scan paper receipt"
      ];
}

- (id)init {
    self = [super init];
    if (self) {
        self.reachableInternet = FALSE;
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.reachableInternet = FALSE;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {

}
- (void)viewDidDisappear:(BOOL)animated {
    if (self.defaultInventory42 != nil) {
        [[self defaultInventory42] stopUpdating];
    }
}



- (void) testReachableInternet {
    
    if (self.defaultInventory42 == nil) {
        self.defaultInventory42 = [AHReach reachForHost: @"inventory42-focusdays14.rhcloud.com"];
        [self.defaultInventory42 startUpdatingWithBlock:^(AHReach *reach) {
            if([reach isReachable]) {
                NSURL *url = [NSURL URLWithString:@"http://inventory42-focusdays14.rhcloud.com"];
                NSURLRequest *request = [NSURLRequest requestWithURL: url];
                id response = nil;
                NSError *error = nil;
                NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                if (error == nil && [response isKindOfClass: [NSHTTPURLResponse class]] && [response statusCode] == 200 ) {
                    NSHTTPURLResponse *urlResponse = response;
                    self.reachableInternet = TRUE;
                    NSLog(@"REACHABLE!");
                } else {
                    self.reachableInternet = FALSE;
                    NSLog(@"UNREACHABLE - server URL not available!");
                }
            } else {
                self.reachableInternet = FALSE;
                NSLog(@"UNREACHABLE!");
            }
        }];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testReachableInternet];
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
        
        NSInteger index = ((UIButton *)sender).tag;
        ImageModel *model =[[ImagesModel sharedManager] imageModelAtIndex: index];
        BOOL detected = FALSE;
        if (!model.isDynamic) {
            NSString *resourceName = [NSString stringWithFormat:@"image-%ld", (long)index];
            ImageHelper *detector = [ImageHelper fromResourceName:resourceName extension: @"jpg"];
            detected = [detector uploadAndDetectImage];
            if (detected) {
                [[ImagesModel sharedManager] putImageModel:[detector model] index: index];
            } else {
                [self simulateLoader];
            }
        }
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
    
    if (self.reachableInternet) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
	
        for (NSString *action in _CAPTURED_ACTIONS) {
            [actionSheet addButtonWithTitle: action];
        }
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        [actionSheet showInView:self.view];
        
    } else {
        UIAlertView* finalCheck = [[UIAlertView alloc]
                                   initWithTitle:@"Alert - no internet"
                                   message:@"There is no internet connection. Retry?"
                                   delegate:self
                                   cancelButtonTitle:@"Retry"
                                   otherButtonTitles:@"Cancel",nil];
        
        [finalCheck show];
    }
	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0) {
        
    }
    else if(buttonIndex == 1) {
        
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex < [_CAPTURED_ACTIONS count]) {
        if (buttonIndex == 0) {
            /* capture image */
        }
    }
}





@end
