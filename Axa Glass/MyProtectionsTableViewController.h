//
//  MyProtectionsTableViewController.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 27/09/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProtectionsModel.h"
#import "ProtectionModel.h"

@interface MyProtectionsTableViewController : UITableViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ProtectionsModel * models;
@property (nonatomic, strong) ProtectionModel * currentModel;

@end
