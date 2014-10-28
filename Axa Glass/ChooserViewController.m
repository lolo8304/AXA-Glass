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
#import "ImageHelper.h"
#import "ImageModel.h"
#import "MMProgressHUD.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AssetsLibrary/AssetsLibrary.h"

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
      @"From Camera",  @"From Photo Album", @"From Photo Library",  @"From eMail receipt", @"From Barcode", @"From Paper Receipt"
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
                [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                if (error == nil && [response isKindOfClass: [NSHTTPURLResponse class]] && [response statusCode] == 200 ) {
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


- (void)detect: (NSInteger) index {
    ImageModel *model =[[ImagesModel sharedManager] imageModelAtIndex: index];
    BOOL detected = FALSE;
    if (!model.isDynamic) {
        [[MMProgressHUD sharedHUD] setOverlayMode:MMProgressHUDWindowOverlayModeLinear];
        [MMProgressHUD showWithTitle:@"Analyzing image" status:0];
        NSString *resourceName = [NSString stringWithFormat:@"image-%ld", (long)index];
        ImageHelper *detector = [ImageHelper fromResourceName:resourceName extension: @"jpg"];
        detected = [detector uploadAndDetectImage];
        if (detected) {
            [[ImagesModel sharedManager] putImageModel:[detector model] index: index];
            [MMProgressHUD dismissWithSuccess:@"Detected!"];
        } else {
            [self simulateLoader];
            [MMProgressHUD dismissWithError:@"Detection aborted" afterDelay: 2];
        }
    }
    
}

- (IBAction)selectImage:(id)sender {
    
    NSInteger index = ((UIButton *)sender).tag;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
        [self detect:index];
        
        NSLog(@"Finished work in background");
        dispatch_async(dispatch_get_main_queue(), ^ {
            NSLog(@"Back on main thread");
            
            if (self.isViewLoaded && self.view.window && self.parentViewController != nil) {
                [self performSegueWithIdentifier:@"showImageMatch" sender:sender];}
            
        });
    });

}

- (void)simulateLoader {
	float progress = 0.0;
	
	while (progress < 1.0) {
		progress += 0.02;
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
/** "From Camera",  "From Camera Roll",  "From Library", "From eMail receipt", "From Barcode", "From Paper Receipt" **/
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex > 0 && buttonIndex <= [_CAPTURED_ACTIONS count]) {
        switch (buttonIndex) {
            case 1:
                /** camera */
                [self captureCamera];
                break;
            case 2:
                /** gallery **/
                [self pickFromGallery];
                break;
            case 3:
                /** library **/
                [self pickFromLibrary];
                break;
                
            default:
                break;
        }
    }
}

/** http://www.techotopia.com/index.php/Accessing_the_iOS_7_Camera_and_Photo_Library **/

- (void) captureCamera {
    if (![self hasValidCameraFeatures] || ![self hasValidPhotoAlbumFeatures]) {
        return;
    }
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void) pickFromGallery {
    if (![self hasValidPhotoAlbumFeatures]) {
        return;
    }
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void) pickFromLibrary {
    if (![self hasValidPhotoLibraryFeatures]) {
        return;
    }
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}


- (BOOL) hasValidCameraFeatures {
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error - Camera"
                              message: @"Failed to capture a picture. Camera feature is not available "
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return FALSE;
    }
    return TRUE;
}

- (BOOL) hasValidPhotoAlbumFeatures {
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error - Camera roll"
                              message: @"Failed to access Camera roll. Feature is not available or not allowed"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return FALSE;
    }

    return TRUE;
}

- (BOOL) hasValidPhotoLibraryFeatures {
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Error - Photos Library"
                              message: @"Failed to access photo library. Feature is not available or not allowed"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return FALSE;
    }
    return TRUE;

}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^ {
            
            [[MMProgressHUD sharedHUD] setOverlayMode:MMProgressHUDWindowOverlayModeLinear];
            [MMProgressHUD showWithTitle:@"Analyzing image" status:0];

            UIImage *scaledImage = [ImageHelper scaleImageSmall:image];
            /*no scaling */
            NSString *newFileName = [ImageHelper saveImageToFileWithoutExtension:scaledImage withName:[ImageHelper newImageNameWithoutExtension]];
            
            ImageHelper *imageHelper = [ImageHelper fromFileWithPath:newFileName];
            BOOL detected = imageHelper.uploadAndDetectImage;
            if (detected) {
                [[ImagesModel sharedManager] putImageModel:[imageHelper model] index: 0];
                [MMProgressHUD dismissWithSuccess:@"Detected!"];
            } else {
                [self simulateLoader];
                [MMProgressHUD dismissWithError:@"Detection aborted" afterDelay: 2];
            }
            
            NSLog(@"Finished work in background");
            dispatch_async(dispatch_get_main_queue(), ^ {
                if (self.isViewLoaded && self.view.window && self.parentViewController != nil) {
                    [self performSegueWithIdentifier:@"showImageMatch" sender:0];}
                NSLog(@"Back on main thread");
            });
        });
    }
}

-(void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
