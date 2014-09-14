//
//  InsurenceOptionCell.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 12/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "InsurenceOptionCell.h"

@implementation InsurenceOptionCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
	}
	return self;
}

- (void)awakeFromNib {
	UIFont *myFont = [ UIFont fontWithName:FONT_DEMI size: 15.0 ];
	self.desc.font = myFont;
	self.desc.textColor = [UIColor colorWithRed:0.925490F green:0.925490F blue:0.925490F alpha:1.0F] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}


@end
