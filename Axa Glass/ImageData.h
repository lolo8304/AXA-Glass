//
//  ImageData.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/10/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageData : NSObject

@property (nonatomic, strong) NSURL * imageURL;
@property (nonatomic, strong) NSData *tempAssetsLibraryImage;
@property (nonatomic, strong) NSConditionLock* albumReadLock;
- (id)initWithURL: (NSURL *) url;

+ (NSData *)imageData:(NSURL *)url;

@end
