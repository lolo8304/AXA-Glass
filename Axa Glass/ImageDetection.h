//
//  ImageDetection.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 25/10/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageDetection : NSObject

@property (nonatomic, strong) NSString * fileName;
@property (nonatomic, strong) NSURL * imageURL;

+ (ImageDetection *)detectResourceNamed:(NSString *)file extension: (NSString *)ext;
+ (ImageDetection *)detectImageByURL:(NSURL *)url;

- (id)initWithURL: (NSURL *) url;
- (NSData*) uploadAndDetectImage;

@end
