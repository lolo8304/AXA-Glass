//
//  SimilarImage.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "SimilarImage.h"

@implementation SimilarImage


- (id) initWithServerJson:(NSDictionary*)dict {
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        self = [self init];
        if (self) {
            self.keywords = dict[@"pt"];
            self.imageURL = [NSURL URLWithString: dict[@"tu"]];
            self.price = 0;
            self.currency = @"EUR";
            
            return self;
        }
    }
    return nil;
}


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

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ %@ %@ %@", self.keywords, self.imageName, self.price, self.currency];
}



@end
