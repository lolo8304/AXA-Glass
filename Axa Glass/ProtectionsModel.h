//
//  ProtectionsModel.h
//  Axa Glass
//
//  Created by Lorenz Hänggi on 28/09/14.
//  Copyright (c) 2014 Axa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ProtectionsModel : NSObject

+ (ProtectionsModel*) sharedManager;//singleton

@property (nonatomic, strong) NSMutableArray * items;

- (void) loadData;

- (ImageModel *) modelAtIndex:(NSUInteger) index;


@end
