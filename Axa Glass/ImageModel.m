//
//  ImageModel.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ImageModel.h"
#import "SimilarImage.h"

@implementation ImageModel

- (id)init {
    self = [super init];
    if (self) {
			
	}
    return self;
}

- (id) initWithServerJson:(NSDictionary*)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        self = [self init];
        if (self) {
            self.keywords = dict[@"keywords"];
            self.imageName = dict[@"image"];
            self.categorizations = [[NSArray alloc]initWithObjects:@"none", nil];
            
            self.price = 0;
            self.currency = @"EUR";
            self.similarImages = [NSMutableArray array];
            
            for (NSDictionary * item in dict[@"similarImages"]) {
                SimilarImage * similarImage = [[SimilarImage alloc] initWithServerJson:item];
                [self.similarImages addObject:similarImage];
            }
            
            return self;
        }
    }
    return nil;
}

- (id) initWithJson:(NSDictionary*)dict {
	
	if ([dict isKindOfClass:[NSDictionary class]]) {
		self = [self init];
		if (self) {
			self.keywords = dict[@"keywords"];
			self.imageName = dict[@"image"];
			self.categorizations = dict[@"categorizations"];
			
			self.price = dict[@"prize"][@"value"];
			self.currency = dict[@"prize"][@"currency"];
			self.similarImages = [NSMutableArray array];
			
			for (NSDictionary * item in dict[@"similarImages"]) {
				SimilarImage * similarImage = [[SimilarImage alloc] initWithJson:item];
				[self.similarImages addObject:similarImage];
			}
			
			return self;
		}
	}
	return nil;
}


- (NSString *)description {
	NSMutableString  * string = [NSMutableString stringWithFormat:@"%@ %@ %@ %@ %@ - similars images count %lu", self.keywords, self.imageName, self.categorizations, self.price, self.currency, (long)[self.similarImages count]];
	for (SimilarImage * similarImage in self.similarImages) {
		[string appendFormat:@"\n%@", similarImage];
	}
	return string;
	
}

@end
