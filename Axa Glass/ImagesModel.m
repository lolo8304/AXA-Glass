//
//  ImagesModel.m
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ImagesModel.h"

@implementation ImagesModel

+ (ImagesModel*)sharedManager {
    static ImagesModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}



- (id)init {
    self = [super init];
    if (self) {
		
        self.images = [NSMutableArray array];
		self.currentImageIndex = 0;
	}
    return self;
}

- (ImageModel *) imageModelAtIndex:(NSUInteger) index {
	if (index < [self.images count]) {
		return self.images[index];
	}
	return nil;
}

- (ImageModel *) imageModelAtCurrentIndex {
	return [self imageModelAtIndex:self.currentImageIndex];
}


- (void) fakeData {
	NSError * error = nil;
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *path = [bundle pathForResource: @"image-0" ofType:@"json"];
	NSString *data = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	if (error!=nil) {
		LoggerError(0, @"File not found %@", path);
	}
	id jsonData = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
	
	if (error!=nil) {
		LoggerError(0, @"JsonData is empty for %@", path);
	}
	
	ImageModel * imageModel = [[ImageModel alloc] initWithJson:jsonData];
	if (!IsEmpty(imageModel)) {
		[self.images addObject:imageModel];
	}
}


@end
