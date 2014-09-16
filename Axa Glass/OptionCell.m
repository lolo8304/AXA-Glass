//
//  OptionCell.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 16/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "OptionCell.h"

@implementation OptionCell

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
	self.name.font = myFont;
	self.name.textColor = [UIColor colorWithRed:0.925490F green:0.925490F blue:0.925490F alpha:1.0F] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}


@end
