//
//  SimilarImage.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "SimilarImage.h"

@implementation SimilarImage




- (id) initWithJson:(NSDictionary*)dict {
	
	if ([dict isKindOfClass:[NSDictionary class]]) {
		self = [self init];
		if (self) {
			self.keywords = dict[@"pt"];
			self.imageName = dict[@"image"];
			self.price = dict[@"prize"][@"value"];
			self.currency = dict[@"prize"][@"currency"];
			
			return self;
		}
	}
	return nil;
}



@end
