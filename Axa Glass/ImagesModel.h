//
//  ImagesModel.h
//  Axa Glass
//
//  Created by Nicolas Lauquin on 11/09/2014.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimilarImage.h"
#import "ImageModel.h"

@interface ImagesModel : NSObject

+ (ImagesModel*) sharedManager;//singleton

@property (nonatomic, strong) NSMutableArray * images;
@property (nonatomic) NSInteger currentImageIndex;

- (void) loadData;

- (ImageModel *) imageModelAtIndex:(NSUInteger) index;
- (NSUInteger) addImageModel:(ImageModel *) imageModel;
- (ImageModel *) putImageModel: (ImageModel *) imageModel index:(NSUInteger) index;
- (ImageModel *) imageModelAtCurrentIndex;

@end
