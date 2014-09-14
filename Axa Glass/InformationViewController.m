//
//  InformationViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 12/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "InformationViewController.h"

@implementation InformationViewController

- (void) viewWillAppear:(BOOL)animated {
	[self setModalPresentationStyle:UIModalPresentationCurrentContext];
}

- (void)viewDidLoad {
	[self setModalPresentationStyle:UIModalPresentationCurrentContext];
}

- (IBAction)close:(id)sender {
	[self dismissViewControllerAnimated:YES completion:Nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	[self setModalPresentationStyle:UIModalPresentationCurrentContext];

}

@end
