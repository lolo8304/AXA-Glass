//
//  MyProtectionCell.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 12/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "MyProtectionCell.h"

@implementation MyProtectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    /*
    UIFont *myFontText = [ UIFont fontWithName:FONT_BOOK size: 15.0 ];
    UIFont *myFontPrice = [ UIFont fontWithName:FONT_DEMI size: 15.0 ];
    UIFont *myFontType = [ UIFont fontWithName:FONT_BOOK size: 15.0 ];
    self.title.font = myFontText;
    self.type.font = myFontType;
     */
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
