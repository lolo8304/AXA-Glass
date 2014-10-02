//
//  MyProtectionCell.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/09/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

//
//  ResultImageCell.h
//  Axa Glass
//
//  Created by Nicolas Lauquin on 12/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProtectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIImageView *coveredImage;
@property (weak, nonatomic) IBOutlet UILabel *covered;

/* if type == "coverage" */
@property (weak, nonatomic) IBOutlet UILabel *premium;
@property (weak, nonatomic) IBOutlet UILabel *insuredSum;
@property (weak, nonatomic) IBOutlet UILabel *deductible;

/* if type == "object-capture" */
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *category;


@end
