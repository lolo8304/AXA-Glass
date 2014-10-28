//
//  ImageData.m
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/10/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import "ImageData.h"
#import "AssetsLibrary/ALAssetRepresentation.h"

@implementation ImageData


- (NSData *) imageDataFromAssetsLibrary {
    enum {
        WDASSETURL_PENDINGREADS = 1,
        WDASSETURL_ALLFINISHED = 0
    };
    NSAssert(![NSThread isMainThread], @"can't be called on the main thread due to ALAssetLibrary limitations");
    self.albumReadLock = [[NSConditionLock alloc] initWithCondition:WDASSETURL_PENDINGREADS];
    
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    [assetLibrary assetForURL:self.imageURL resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        Byte *buffer = (Byte*)malloc((long)rep.size);
        NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:(long)rep.size error:nil];
        self.tempAssetsLibraryImage = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
        // notifies the lock that "all tasks are finished"
        [self.albumReadLock lock];
        [self.albumReadLock unlockWithCondition:WDASSETURL_ALLFINISHED];
    } failureBlock:^(NSError *err) {
        // important: notifies lock that "all tasks finished" (even though they failed)
        [self.albumReadLock lock];
        [self.albumReadLock unlockWithCondition:WDASSETURL_ALLFINISHED];
        NSLog(@"Error: %@",[err localizedDescription]);
    }];
    [self.albumReadLock lockWhenCondition:WDASSETURL_ALLFINISHED];
    [self.albumReadLock unlock];
    self.albumReadLock = nil;
    
    NSData *data = self.tempAssetsLibraryImage;
    self.tempAssetsLibraryImage = nil;
    return data;
}

- (NSData *) imageData {
    if ([self.imageURL.scheme isEqualToString:@"assets-library"]) {
        return self.imageDataFromAssetsLibrary;
    } else {
        return [NSData dataWithContentsOfURL:self.imageURL];
    }
}


-(id)initWithURL:(NSURL *)url {
    if ((self = [super init]) && url) {
        self.imageURL = url;
        return self;
    }
    return nil;
}

+ (NSData *)imageData:(NSURL *)url {
    return [[[ImageData alloc] initWithURL: url] imageData];
}


@end
