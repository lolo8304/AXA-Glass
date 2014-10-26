//
//  ImageDetection.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 25/10/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageHelper.h"

@interface ImageDetection : NSObject

@property (nonatomic, strong) ImageHelper * image;

+ (ImageDetection *)fromImage:(ImageHelper *) image;

- (id)initWithImage: (ImageHelper *) image;
- (NSDictionary*) uploadAndDetect;

@end
