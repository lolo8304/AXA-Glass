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
@property (weak, nonatomic) IBOutlet UILabel *keyword;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (nonatomic) BOOL isBestMatch;

@end