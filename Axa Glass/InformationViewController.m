//
//  InformationViewController.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 12/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "InformationViewController.h"

@implementation InformationViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationItem.backBarButtonItem.title = @"Insured?";
}

- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated: YES];

}


@end
