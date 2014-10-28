//
//  ImageHelper.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 26/10/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageData.h"

@interface ImageHelper : NSObject

@property (nonatomic, strong) NSString * fileName;
@property (nonatomic, strong) NSURL * imageURL;
@property (nonatomic, strong) NSURL * publicImageURL;
@property (nonatomic, strong) NSDictionary *detectedResult;
@property (nonatomic, strong) ImageModel *model;

+ (ImageHelper *)fromFileWithPath:(NSString *)fileName;
+ (ImageHelper *)fromResourceName:(NSString *)file extension: (NSString *)ext;
+ (ImageHelper *)fromURL:(NSURL *)url;

+ (UIImage *)scaleImageSmall:(UIImage *)image;
+ (UIImage *)scaleImage:(UIImage *)image toSize:(int)targetSize;
+ (UIImage *)loadImageFromFile:(NSString *)name;

+ (NSString *)saveImageToFile:(UIImage *)image withName:(NSString *)name;
+ (NSString *)saveImageToFileWithoutExtension:(UIImage *)image withName:(NSString *)name;
+ (NSString *)saveImageToFileWithExtension:(UIImage *)image withName:(NSString *)name extension: (NSString *)ext;

+ (NSString *)imageNameFromUUID:(NSUUID *)uuid extension:(NSString *)ext;
+ (NSString *)newImageNameWithExtension:(NSString *)ext;
+ (NSString *)newImageNameWithoutExtension;


- (id)initWithURL: (NSURL *) url;


- (NSData *) imageData;
- (BOOL)isLocalResource;
- (BOOL)isPublicAvailable;
- (BOOL)hasDetectedResult;
- (NSURL *)uploadImage;
- (BOOL)uploadAndDetectImage;


@end
