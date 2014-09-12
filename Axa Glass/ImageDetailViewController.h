//
//  ImageDetailViewController.h
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"

@interface ImageDetailViewController : UIViewController <BSKeyboardControlsDelegate, UITextFieldDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *yourProtectionTitle;

@end
