//
//  ImageHelper.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 26/10/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageHelper : NSObject

@property (nonatomic, strong) NSString * fileName;
@property (nonatomic, strong) NSURL * imageURL;
@property (nonatomic, strong) NSURL * publicImageURL;
@property (nonatomic, strong) NSDictionary *detectedResult;

+ (ImageHelper *)fromResourceName:(NSString *)file extension: (NSString *)ext;
+ (ImageHelper *)fromURL:(NSURL *)url;

- (id)initWithURL: (NSURL *) url;
- (BOOL)isLocalResource;
- (BOOL)isPublicAvailable;
- (NSURL *)uploadImage;
- (void)detectImage: (NSURL *) url;


@end
