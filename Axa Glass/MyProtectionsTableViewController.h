//
//  MyProtectionsTableViewController.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 27/09/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProtectionsTableViewController : UITableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ImageModel * imageModel;

@end
