//
//  InsurenceOptionCell.h
//  Axa Glass
//
//  Created by Nicolas Lauquin on 12/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProtectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UIButton *informationButton;

@property (weak, nonatomic) IBOutlet UIImageView *status;

@end
